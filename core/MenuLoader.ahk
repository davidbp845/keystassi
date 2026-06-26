#Include ../utils/Debug.ahk
#Include MenuNode.ahk

class MenuLoader {

    static debugMode := false

    static menuNodes := Map()

    static load(path) {

        sections := IniRead(path)
        sectionsArray := StrSplit(sections, "`n")

        ; read all nodes and first create them without children
        ; -------------------------------------------
        for section in sectionsArray {
            if !RegExMatch(section, "^node:")
                continue
            nodeId := SubStr(section, 6)
            nodeLabel := IniRead(path, section, "label", nodeId)
            nodeChildren := IniRead(path, section, "children", "")
            nodeSteps := IniRead(path, section, "steps", "")
            if nodeChildren != "" && nodeSteps != "" {
                if MenuLoader.debugMode
                    UtilsDebug.Debug("Error nodeId" nodeId)
                throw "Error a node with children must not have steps"
            }

            MenuLoader.menuNodes[nodeId] := MenuNode(nodeId, nodeLabel, nodeSteps)
            if MenuLoader.debugMode
                UtilsDebug.Debug("MenuLoader Add node " nodeId)
        }

        ; read created nodes except root and add them as children of their parent
        ; -------------------------------------------
        for nodeId, node in MenuLoader.menuNodes {
            if nodeId != "root" {
                section := "node:" nodeId
                parentId := IniRead(path, section, "parent", "")
                parentNodeChildren := IniRead(path, "node:" parentId, "children", "")
                if parentNodeChildren != "" {
                    for _, childId in StrSplit(parentNodeChildren, ",") {
                        if childId = nodeId {
                            childNode := MenuLoader.menuNodes[childId]
                            MenuLoader.menuNodes[parentId].addChild(childNode)
                            if MenuLoader.debugMode
                                UtilsDebug.Debug("MenuLoader node " childId " added as child of " parentId)
                        }
                    }
                }
            }
        }
    }
}
