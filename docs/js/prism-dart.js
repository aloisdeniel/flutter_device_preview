(function (Prism) {
    var className = /\b[A-Z_$](?:\w*[a-z$0-9]\w*)?\b/;
    var keywords = [
        /\b(?:async|sync|yield)\*/,
        /\b(?:abstract|assert|async|await|break|case|catch|class|const|continue|covariant|default|deferred|do|dynamic|else|enum|export|extension|external|extends|factory|final|int|string|finally|for|Function|get|hide|if|implements|interface|import|in|library|mixin|new|null|on|operator|part|rethrow|return|set|show|static|super|switch|sync|this|throw|try|typedef|var|void|while|with|yield)\b/
    ];

    Prism.languages.dart = Prism.languages.extend('clike', {
        'string': [
            {
                pattern: /r?("""|''')[\s\S]*?\1/,
                greedy: true
            },
            {
                pattern: /r?("|')(?:\\.|(?!\1)[^\\\r\n])*\1/,
                greedy: true
            }
        ],
        'keyword': keywords,
        'operator': /\bis!|\b(?:as|is)\b|\+\+|--|&&|\|\||<<=?|>>=?|~(?:\/=?)?|[+\-*\/%&^|=!<>]=?|\?/,
        'class-name': [
            className,

            // variables and parameters
            // this to support class names (or generic parameters) which do not contain a lower case letter (also works for methods)
            /\b[A-Z]\w*(?=\s+\w+\s*[;,=())])/
        ],
        'function': [
            Prism.languages.clike.function,
            {
                pattern: /(\:\:)[a-z_]\w*/,
                lookbehind: true
            }
        ],
        'number': /\b0b[01][01_]*L?\b|\b0x[\da-f_]*\.?[\da-f_p+-]+\b|(?:\b\d[\d_]*\.?[\d_]*|\B\.\d[\d_]*)(?:e[+-]?\d[\d_]*)?[dfl]?/i,

    });

    Prism.languages.insertBefore('dart', 'string', {
        'triple-quoted-string': {
            // http://openjdk.java.net/jeps/355#Description
            pattern: /"""[ \t]*[\r\n](?:(?:"|"")?(?:\\.|[^"\\]))*"""/,
            greedy: true,
            alias: 'string'
        }
    });

    Prism.languages.insertBefore('dart', 'class-name', {
        'annotation': {
            alias: 'keyword',
            pattern: /@\w+/,
            lookbehind: true
        },
        'generics': {
            pattern: /<(?:[\w\s,.&?]|<(?:[\w\s,.&?]|<(?:[\w\s,.&?]|<[\w\s,.&?]*>)*>)*>)*>/,
            inside: {
                'class-name': className,
                'keyword': keywords,
                'punctuation': /[<>(),.:]/,
                'operator': /[?&|]/
            }
        }
    });
}(Prism));