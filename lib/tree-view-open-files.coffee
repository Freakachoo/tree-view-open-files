{requirePackages} = require 'atom-utils'
TreeViewOpenFilesView = require './tree-view-open-files-view'

module.exports =
	treeViewOpenFilesView: null

	config:
		maxHeight:
			type: 'integer'
			default: 250
			min: 0
			description: 'Maximum height of the list before scrolling is required. Set to 0 to disable scrolling.'

		overflow:
			type: 'boolean'
			default: true
			description: 'If checked list will be expanded with opening files (overflow: visible)'

		filePath:
			type: 'boolean'
			default: true
			description: 'Show file paths after file name'

	activate: (state) ->
		requirePackages('tree-view').then ([treeView]) =>
			@treeViewOpenFilesView = new TreeViewOpenFilesView

			if treeView.treeView
				@treeViewOpenFilesView.show()

			atom.commands.add 'atom-workspace', 'tree-view:toggle', =>
				if treeView.treeView?.is(':visible')
					@treeViewOpenFilesView.show()
				else
					@treeViewOpenFilesView.hide()

			atom.commands.add 'atom-workspace', 'tree-view:show', =>
				@treeViewOpenFilesView.show()

	deactivate: ->
		@treeViewOpenFilesView.destroy()

	serialize: ->
		#TreeViewOpenFilesViewState: @TreeViewOpenFilesView.serialize()
