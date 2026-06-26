Class Hooks {
    static actions := Map()
    static filters := Map()

    static add_action(name, func) {
        this.actions[name] := func
        UtilsDebug.Debug "Hooks.add_action: " name
    }

    static add_filter(name, func) {
        this.filters[name] := func
        UtilsDebug.Debug "Hooks.add_filter: " name
    }

    static do_action(name, obj := "") {
        if this.actions.Has(name) {
            try {
                UtilsDebug.Debug "Hooks.do_action: " name " obj: " Type(obj) " function: " this.actions[name].Name
                if obj != "" {
                    this.actions[name](obj)
                }
                else
                    this.actions[name]()
            } catch Error as err {
                OutputDebug "Error in do_action: " err.Message " hookname: " name " obj: " Type(obj)
            }
        }
    }

    static do_action1(name, obj := "", param1 := "") {
        if this.actions.Has(name) {
            try {
                UtilsDebug.Debug "Hooks.do_action1: " name
                if obj != "" {
                    this.actions[name](obj, param1)
                }
                else
                    this.actions[name]()
            } catch Error as err {
                OutputDebug "Error in do_action1: " err.Message " hookname: " .
                    name " obj: " Type(obj) " param1: " Type(param1)
            }
        }
    }

    static do_action2(name, obj := "", param1 := "", param2 := "") {
        if this.actions.Has(name) {
            try {
                UtilsDebug.Debug "Hooks.do_action2: " name
                if obj != "" {
                    this.actions[name](obj, param1, param2)
                }
                else
                    this.actions[name]()
            } catch Error as err {
                OutputDebug "Error in do_action1: " err.Message " hookname: " .
                    name " obj: " Type(obj) " param1: " param1 " param2: " param2
            }
        }
    }

    static apply_filter(name, value:="", obj:="") {
        if this.filters.Has(name) {
            try {
                ;UtilsDebug.Debug "Hooks.apply_filter: " name
                if(obj!="") {
                    value := this.filters[name](value, obj)   
                }
                else {
                    value := this.filters[name](value)
                }
            } catch Error as err {
                OutputDebug "Error in apply_filter: " err.Message " hookname: " .
                    name
            }
        }
        return value
    }
}