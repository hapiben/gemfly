require 'find'

count = 0
existing = 0
Find.find('githooks').each do |f|
  next if File.directory? f

  full_path =  File.expand_path(f)
  target_path = File.expand_path(File.join('.git', 'hooks', File.basename(f, '.sh')))

  if File.exists? target_path
    File.delete target_path
    existing += 1
  end

  %x(cp #{full_path} #{target_path})
  %x(chmod +x #{target_path})
  count += 1
end

p "Installed #{count} (#{count - existing} new) hooks"
