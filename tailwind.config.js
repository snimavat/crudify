const colors = require('tailwindcss/colors')

module.exports = {
    //prefix: 'tw-',
    darkMode: false,
    theme: {
        colors: {
            black: colors.black,
            white: colors.white,
            gray: colors.blueGray,
            //teal: colors.teal,
            indigo: colors.indigo,
        },
        screens: {
            'sm': '640px',
            'lg': '1024px',
        },
        borderWidth: {
            default: '1px',
            '0': '0',
            '2': '2px'
        },

        cursor: {
            pointer: 'pointer',
            wait: 'wait'
        },

        extend: {
            colors: {},
            fontSize: {
                'xxs': '.5rem',
            }
        }
    },
    variants: {},
    plugins: [
        require('@tailwindcss/forms')
    ],
    corePlugins: {
        stroke: false,
        strokeWidth: false,
        resize: false,
        tableLayout: false,
        borderCollapse: false,

        float: false,
        tableLayout: false,
        gap: true,

        gridAutoFlow: false,
        gridTemplateColumns: true,
        gridColumn: true,
        gridColumnStart: true,
        gridColumnEnd: true,
        gridTemplateRows: false,
        gridRow: false,
        gridRowStart: false,
        gridRowEnd: false,


        backgroundAttachment: false,
        backgroundOpacity: false,
        backgroundPosition: false,
        backgroundRepeat: false,
        backgroundSize: false,
        borderCollapse: false,

        borderOpacity: false,

        divideColor: false,
        divideOpacity: false,
        divideWidth: false,

        fill: false,
        letterSpacing: false,

        objectFit: false,
        objectPosition: false,

        pointerEvents: false,

        resize: false,
        rotate: false,

        scale: false,
        skew: false,

        userSelect: false,

        transitionProperty: false,
        transitionTimingFunction: false,
        transitionDuration: false,
        transitionDelay: false,

        transform: false,
        transformOrigin: false,
        translate: false,
    }
}
