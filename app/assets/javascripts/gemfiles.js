(function() {
	Gemfiles = (function() {
		var options = {
			lineNumbers: true
			,tabSize: 2
			,theme: 'material'
		}

		return {
			editors: { }
			,init: (function() {
				var self = this;

				self.initUpdatedGemfileEditor();
				self.initGemfileEditor();
				self.initEvents();
			})

			,initGemfileEditor: (function() {
				var self = this,
					editor = CodeMirror.fromTextArea(document.getElementById('gemfile'), options);

				editor.focus();
				self.editors['gemfile'] = editor;
			})

			,initUpdatedGemfileEditor: (function() {
				var self = this,
					editor = CodeMirror.fromTextArea(document.getElementById('updated_gemfile'), options);

				self.editors['updated_gemfile'] = editor;
			})

			,initEvents: (function() {
				var self = this,
					updateBtn = $('#update-gemfile');

				updateBtn.on('click', function() {
					self.setReadOnlyEditors(true);
				})

			})

			,setReadOnlyEditors: (function(enable) {
				var self = this;

				$.each(self.editors, function(index, editor) {
					editor.setOption('readOnly', enable);
				})
			})
		}
	})();

	Gemfiles.init();
})();