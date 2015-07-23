class Gemfile
  include ActiveModel::Model

  REGEX_COMMENTS = /#.*/
  REGEX_NEWLINE = /\r\n|\r|\n/
  REGEX_GEM_NAME = /gem\s*['|"](\S*)['|"](\s|.*)/
  REGEX_GEM_VERSION = /(\d\.\d\.?[\d\.]?*)/
  REGEX_GEM_NAME_VERSION = /gem\s*['|"](\S*)[\'|"]\W*([\d*\.]*)?'/

  ATTRIBUTES = [:gemfile, :updated_gemfile, :gems]

  attr_accessor *ATTRIBUTES

  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end

    send(:updated_gemfile=, gemfile.clone)

    sanitize_gem_content
    update_gem_content
  end

  def sanitize_gem_content
    gem_list = gemfile.split(REGEX_NEWLINE)
    gem_list = gem_list.select { |t| t.present? }
    gem_list.map(&:lstrip!)
    gem_list.map { |gem| gem.slice!(REGEX_COMMENTS) }
    gem_line = gem_list.select { |t| t.starts_with? 'gem' }

    hash = {}
    gem_line.each do |gem|
      name = gem.gsub(REGEX_GEM_NAME, '\1').strip
      version = gem.match(REGEX_GEM_VERSION).captures.first rescue ''
      hash[name] = version
    end
    self.gems = hash
  end

  def update_gem_content
    self.gems.each do |name, version|
      begin
        response = RestClient.get(gem_path(name))
        hash = JSON.parse(response)
        new_version = hash['version']
        name_regex = /['|"]#{Regexp.quote(name)}['|"]/
        name_version_regex = /gem\s*['|"](#{Regexp.quote(name)})[\'|"]\W*([\d*\.]*)?'/

        if version.present?
          updated_gemfile.gsub!(name_version_regex) { |match| match.to_s.gsub!(REGEX_GEM_VERSION, new_version) }
        else
          updated_gemfile.gsub!(name_regex, "'#{name}', '~> #{new_version}'") 
        end
      rescue RestClient::ResourceNotFound => e
      end
    end
  end

  def gem_path(gem_name)
    "https://rubygems.org/api/v1/gems/#{gem_name.strip}.json"
  end

end