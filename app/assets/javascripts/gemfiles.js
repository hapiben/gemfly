(function() {
	Gemfiles = (function() {
		return {
			init: (function() {
				var self = this;

				self.initCodeMirror();
			})

			,initCodeMirror: (function() {
				var self = this,
					textAreas = ['gemfile', 'updated_gemfile'];

				$.each(textAreas, function(index, id) {
					element = document.getElementById(id);
					
					if (element) {
						var editor = CodeMirror.fromTextArea(element, {
							lineNumbers: true
							,tabSize: 2
							,theme: 'neo'
						});

						if (id === 'gemfile') {
							editor.focus();
						}
					}
				});
			})
		}
	})();

	Gemfiles.init();
})();