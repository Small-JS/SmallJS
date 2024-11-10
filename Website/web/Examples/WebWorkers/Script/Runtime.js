// Functionality that is needed for deployed SmallJS apps.
// So the Runtime.js and .map should be deployed along with compiled SmallJS packages.
// This exeption class is thrown on return from a block closure.
// Needed because JS does not support inline returning from an anonymous function.
export class BlockReturn {
    value;
    constructor(value) {
        this.value = value;
    }
}
// Naming conversions form ST to JS and back.
// Static implementations that can be easily be called from ST using INLINE.
export class Naming {
    // ================================ Class Naming
    static classPrefix = "St";
    static classSingletonPrefix = "st";
    static classPostfix = "$class";
    static classStToJs(stName) {
        return this.classPrefix + stName;
    }
    static classJsToSt(jsName) {
        return jsName.startsWith(this.classPrefix) ?
            jsName.slice(this.classPrefix.length) : jsName;
    }
    static metaClassStToJs(stName) {
        return this.classPrefix + stName + this.classPostfix;
    }
    static metaClassJsToSt(jsName) {
        return jsName.startsWith(this.classPrefix) && jsName.endsWith(this.classPostfix) ?
            jsName.substring(this.classPrefix.length, jsName.length - this.classPostfix.length) : jsName;
    }
    static metaClassSingletonStToJs(stName) {
        return this.classSingletonPrefix + stName + this.classPostfix;
    }
    static metaClassSingletonJsToSt(jsName) {
        return jsName.startsWith(this.classSingletonPrefix) && jsName.endsWith(this.classPostfix) ?
            jsName.substring(this.classSingletonPrefix.length, jsName.length - this.classPostfix.length) : jsName;
    }
    // ================================ Variable  Naming
    static variableStToJs(stName) {
        return this.jsReservedWords.includes(stName) ? stName + "$" : stName;
    }
    static variableJsToSt(jsName) {
        return jsName.endsWith('$') ? jsName.slice(-1) : jsName;
    }
    static jsReservedWords = [
        "arguments", "break", "case", "catch",
        "class", "const", "continue", "debugger",
        "default", "delete", "do", "else",
        "enum", "eval", "export", "extends",
        "false", "extends", "false", "finally",
        "for", "function", "if", "import",
        "in", "instanceof", "new", "null",
        "return", "super", "switch", "this",
        "throw", "true", "try", "typeof",
        "var", "void", "while", "with", "yield"
    ];
    // ================================ Method  Naming
    static methodStToJs(stName) {
        let jsName;
        if (this.methodIsConstructor(stName))
            jsName = stName;
        else if (this.methodIsKeyword(stName))
            jsName = "$" + stName.replaceAll(":", "$");
        else if (this.methodIsBinary(stName))
            jsName = this.methodStToJsBinary(stName);
        else // unary
            jsName = "$" + stName;
        return jsName;
    }
    static methodIsConstructor(name) {
        return name == "constructor";
    }
    // Return true if argument is a a unary message selector, i.e. has no arguments.
    static methodIsUnary(term) {
        if (term.length < 1)
            return false;
        if (!CharUtil.isIdentifierStart(term))
            return false;
        for (let i = 1; i < term.length; ++i)
            if (!CharUtil.isIdentifierNext(term[i]))
                return false;
        return true;
    }
    // Return true if argument is a message selector consists of allowed operator characters.
    static methodIsBinary(term) {
        if (term.length < 1)
            return false;
        for (let char of term)
            if (!this.operatorMap.has(char))
                return false;
        return true;
    }
    // Return true if argument is a message selector in the form "selector1:selector2:"
    static methodIsKeyword(term) {
        return term.length > 0 && CharUtil.isIdentifierStart(term) && term.endsWith(":");
    }
    // Return true if argument is a message selector in the form "selector1:"
    static methodIsKeywordSelector(term) {
        if (term.length < 2)
            return false;
        if (!term.endsWith(":"))
            return false;
        if (!CharUtil.isIdentifierStart(term))
            return false;
        for (let i = 1; i < term.length - 1; ++i)
            if (!CharUtil.isIdentifierNext(term[i]))
                return false;
        return true;
    }
    // Map ST binaray method name, consisting of operator characters, to valid JS method name
    static methodStToJsBinary(stName) {
        let jsName = '$';
        for (let stChar of stName) {
            let jsChar = this.operatorMap.get(stChar);
            if (jsChar == undefined)
                throw Error('Invalid operator character: ' + stChar);
            jsName += '$' + jsChar;
        }
        return jsName;
    }
    static operatorMap = new Map([
        ["#", "num"],
        ["$", "dollar"],
        ["%", "percnt"],
        ["&", "amp"],
        ["*", "ast"],
        ["+", "plus"],
        [",", "comma"],
        ["-", "minus"],
        ["/", "sol"],
        ["<", "lt"],
        ["=", "equeals"],
        [">", "gt"],
        ["@", "commat"],
        ["\\", "bsol"],
        ["|", "verbar"],
        ["~", "tilde"]
    ]);
    static methodJsToSt(jsName) {
        let stName = '';
        if (jsName == "constructor")
            stName = jsName;
        else if (jsName.startsWith("$$"))
            stName = this.methodJsToStBinary(jsName);
        else if (jsName.startsWith("$") && jsName.endsWith('$'))
            stName = jsName.slice(1).replaceAll("$", ":");
        else if (jsName.startsWith("$"))
            stName = jsName.slice(1);
        else
            throw Error("Cannot map JS method name to ST: " + jsName);
        return stName;
    }
    // Convert JS operattor function name back to ST.
    // Example: "$gt$equal" converts to ">=".
    static methodJsToStBinary(jsName) {
        let stName = "";
        let start = 2;
        while (start < jsName.length) {
            let end = jsName.indexOf("$", start);
            if (end < 0)
                end = jsName.length;
            let jsOperator = jsName.substring(start, end);
            let stOperator = this.reverseOperatorMap.get(jsOperator);
            if (stOperator == undefined)
                throw Error("Unknown JS operator name: " + jsOperator);
            stName += stOperator;
            start = end + 1;
        }
        return stName;
    }
    static reverseOperatorMap = new Map([
        ["excl", "!"],
        ["num", "#"],
        ["dollar", "$"],
        ["percnt", "%"],
        ["amp", "&"],
        ["ast", "*"],
        ["plus", "+"],
        ["comma", ","],
        ["minus", "-"],
        ["sol", "/"],
        ["lt", "<"],
        ["equeals", "="],
        ["gt", ">"],
        ["commat", "@"],
        ["bsol", "\\"],
        ["verbar", "|"],
        ["tilde", "~"]
    ]);
}
// ====================================== CharUtil
export class CharUtil {
    // Return true if first character in string is an alphabetical character or underscore
    static isIdentifierStart(str) {
        let code = str.charCodeAt(0);
        return (code >= 65 && code < 91) || (code >= 97 && code < 123) || code == 95;
    }
    // Return true if first character in string is an alphabetical character or underscore or a number
    static isIdentifierNext(str) {
        let code = str.charCodeAt(0);
        return (code >= 65 && code < 91) || (code >= 97 && code < 123) || code == 95 || (code >= 48 && code <= 57);
    }
    static isLetter(str) {
        let code = str.charCodeAt(0);
        return (code >= 65 && code < 91) || (code >= 97 && code < 123);
    }
    static isUppercase(str) {
        let code = str.charCodeAt(0);
        return code >= 65 && code <= 90;
    }
    static isLowercase(str) {
        let code = str.charCodeAt(0);
        return code >= 97 && code <= 122;
    }
    static isDigit(str) {
        let code = str.charCodeAt(0);
        return (code >= 48) && (code <= 57);
    }
    static isSpace(str) {
        let code = str.charCodeAt(0);
        return (code == 32) || (code == 9) || (code == 10) || (code == 13);
    }
}
// ====================================== NumUtil
export class NumUtil {
    static gcd(a, b) {
        a = Math.floor(Math.abs(a));
        b = Math.floor(Math.abs(b));
        if (b > a) {
            let temp = a;
            a = b;
            b = temp;
        }
        while (true) {
            if (b == 0)
                return a;
            a = a % b;
            if (a == 0)
                return b;
            b = b % a;
        }
    }
    static gcdBigInt(a, b) {
        a = (a >= 0n ? a : -a);
        b = (b >= 0n ? b : -b);
        if (b > a) {
            let temp = a;
            a = b;
            b = temp;
        }
        while (true) {
            if (b == 0n)
                return a;
            a = a % b;
            if (a == 0n)
                return b;
            b = b % a;
        }
    }
}
//# sourceMappingURL=Runtime.js.map