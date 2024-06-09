// @ExecutionModes({ON_SELECTED_NODE="/main_menu/ScriptsFede/LinkFromTitle"})

import java.io.File 

if (!node.link.file) {
    // get the path of the map
    File file = node.mindMap.file
    if (file == null) {
        JOptionPane.showMessageDialog(ui.frame,
            'The map must be saved to be usable as a link target in the markdown file', "Freeplane", JOptionPane.WARNING_MESSAGE);
        return
    }
    def mapFile = node.mindMap.file.absoluteFile
    def mapDir = mapFile.getParentFile()

    // build the note path
    def filename = node.text.replaceAll(" ", "_").replaceAll("\\W", "") + ".md"

    node.link.file = new File("$mapDir/$filename")
    def nodeAnchor = '[Link to node](' + mapFile + '#' + node.id + ')'
    node.link.file.text = nodeAnchor
}

