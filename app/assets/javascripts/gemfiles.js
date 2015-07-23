(function() {
	Gemfiles = (function() {
		var options = {
			lineNumbers: true
			,tabSize: 2
			,theme: 'neo'
		}

		return {
			updatedGemfile: null
			,init: (function() {
				var self = this;

				self.initUpdatedGemfileEditor();
				self.initGemfileEditor();
			})

			,initGemfileEditor: (function() {
				var self = this,
					editor = CodeMirror.fromTextArea(document.getElementById('gemfile'), options);

				editor.focus();
				// editor.on('scroll', function() {
				// 	var scrollInfo = editor.getScrollInfo(),
				// 		left = scrollInfo.left,
				// 		top = scrollInfo.top;

				// 		console.log(left);

				// 	// self.updatedGemfile.scrollTo(250, 0);
				// });
			})

			,initUpdatedGemfileEditor: (function() {
				var self = this,
					editor = CodeMirror.fromTextArea(document.getElementById('updated_gemfile'), options);

				self.updatedGemfile = editor;
			})
		}
	})();

	Gemfiles.init();
})();