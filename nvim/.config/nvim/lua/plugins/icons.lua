-- Single icon provider. mini.icons supplies icons directly (render-markdown,
-- etc.) and mocks nvim-web-devicons so telescope/trouble keep working without
-- the separate devicons plugin.
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
