require("callred.remap")
require("callred.options")
require("callred.lazy")



Test = function()
     print('what the what')
end


vim.keymap.set('n', "<leader>tt", ":lua test")



