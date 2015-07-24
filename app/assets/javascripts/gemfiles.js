(function() {
	Gemfiles = (function() {
		var options = {
			lineNumbers: true
			,tabSize: 2
			,theme: 'neo'
		}

		return {
			init: (function() {
				var self = this;

				self.initUpdatedGemfileEditor();
				self.initGemfileEditor();
			})

			,initGemfileEditor: (function() {
				var editor = CodeMirror.fromTextArea(document.getElementById('gemfile'), options);

				editor.focus();
			})

			,initUpdatedGemfileEditor: (function() {
				var editor = CodeMirror.fromTextArea(document.getElementById('updated_gemfile'), options);
			})
		}
	})();

	Gemfiles.init();
})();