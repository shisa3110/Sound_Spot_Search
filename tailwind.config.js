module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {},
    fontFamily: {
      title: ['Sans'],
      body:  ['Kiwi Maru', 'Sans'],
    }
  },
  plugins: [require("daisyui")],
  daisyui: {
    darkTheme: false, // ダークモードをONにする場合は削除
    themes: [
      {
        mytheme: {
          ...require("daisyui/src/theming/themes")["retro"],
          "base-200": "F3EBE1"
        },
      },
      'retro'
    ],
  },
}