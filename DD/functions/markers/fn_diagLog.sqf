params [
	["_type", "", [""]],
	["_data", [], []]
];

private _str = "";

switch (_type) do {
	case "DEBUG": {_str = "[DD] (MapShare) DEBUG: " + (_data joinString "")};
	case "ERROR": {_str = "[DD] (MapShare) ERROR: " + (_data joinString "")};
	case "WARNING": {_str = "[DD] (MapShare) WARNING: " + (_data joinString "")};
	case "INFO": {_str = "[DD] (MapShare) INFO: " + (_data joinString "")};
	default {_str = "[DD] (MapShare) UNDEFINED_TYPE: " + (_data joinString "")};
};

diag_log text _str;