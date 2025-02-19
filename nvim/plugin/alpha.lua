-- some snippets from https://github.com/BeyondMagic/lovemii/blob/3763a6dfe2986081e13de14f0324eb1a72ace020/_config/nvim/lua/screen.lua 
-- and lots of things from https://github.com/dtr2300/nvim/blob/main/lua/config/plugins/alpha.lua
-- also headers include references to Tom Bloom's Kill Six Billion Demons, 
-- and some ascii cats from  https://user.xmission.com/~emailbox/ascii_cats.htm
local function layout()
  ---@param sc string
  ---@param txt string
  ---@param keybind string?
  ---@param keybind_opts table?
  ---@param opts table?
  ---@return table
      local function button(sc, txt, keybind, keybind_opts, opts)
        local def_opts = {
          cursor = 3,
          align_shortcut = "right",
          hl_shortcut = "AlphaButtonShortcut",
          hl = "AlphaButton",
          width = 35,
          position = "center",
        }
        opts = opts and vim.tbl_extend("force", def_opts, opts) or def_opts
        opts.shortcut = sc
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<Leader>")
        local on_press = function()
          local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
          vim.api.nvim_feedkeys(key, "t", false)
        end
        if keybind then
          keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
          opts.keymap = { "n", sc_, keybind, keybind_opts }
        end
        

	return { type = "button", val = txt, on_press = on_press, opts = opts }
      end

    local function mru()
          local result = {}
          for _, filename in ipairs(vim.v.oldfiles) do
            if vim.loop.fs_stat(filename) ~= nil then
              local icon, hl = require("nvim-web-devicons").get_icon(filename, vim.fn.fnamemodify(filename, ":e"))

              if icon == nil then
                icon = "󰈙"
              end

              local filename_short = string.sub(vim.fn.fnamemodify(filename, ":t"), 1, 30)
              table.insert(
                result,
                button(
                  tostring(#result + 1),
                  string.format("%s  %s", icon, filename_short),
                  string.format("<Cmd>e %s<CR>", filename),
                  nil,
                  { hl = { { "AlphaButton", 0, 3 }, { "Normal", 5, #filename_short + 5 } } }
                )
              )
              if #result == 9 then
                break
              end
            end
          end
          return result
        end
    	math.randomseed( os.time() )
		local headers = {
		          {
		                "  \\    /\\",
		                "   )  ( ')",
		                "   (  /  )",
		                "jgs \\(__)|",
	            },
	            {
                "((      /|_/|",
                " \\\\.._.'  , ,\\",
                " /\\ | '.__ v /",
                "(_ .   /   \"",
                " ) _)._  _ /",
                "'.\\ \\|( / ( mrf",
                "  '' ''\\\\ \\\\",
                },
                -- you *gotta* go to the moon
                {
                "Consider reading popular webcomic",
                "Kill Six Billion Demons by ABBADON ",
                "-- Moon Wizard Cat",
                "                                               ",
                "            *     ,MMM8&&&.            *       ",
                "                  MMMM88&&&&&    .             ",
                "                 MMMM88&&&&&&&                 ",
                "     *           MMM88&&&&&&&&                 ",
                "             ^   MMM88&&&&&&&&                 ",
                "            / \\  'MMM88&&&&&&'                 ",
                "           /   \\   'MMM8&&&'      *    _       ",
                "        __/     \\__                    \\\\      ",
                "         =) ^Y^ (=   |\\_/|              ||    '",
                "          \\  ^  /    )a a '._.-\"\"\"\"-.  //      ",
                "           )=*=(    =\\T_= /    ~  ~  \\//       ",
                "          /     \\     `\"`\\   ~   / ~  /        ",
                "          |     |         |~   \\ |  ~/         ",
                "         /| | | |\\         \\  ~/- \\ ~\\         ",
                "         \\| | |_|/|        || |  // /`         ",
                "  jgs_/\\_//_// __//\\_/\\_/\\_((_|\\((_//\\_/\\_/\\_  ",
                "  |  |  |  | \\_) |  |  |  |  |  |  |  |  |  |  ",
                "  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ",
                "  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ",
                "  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ",
                "  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ",
                },
                {
                "     /\\__/\\          ",
                "    /`    '\\         ",
                "  === 0  0 ===       ",
                "    \\  --  /         ",
                "   /        \\        ",
                "  /          \\       ",
                " |            |      ",
                "  \\  ||  ||  /       ",
                "   \\_oo__oo_/#######o",
                },
		        -- blockified kill six billion demons quotes using https://patorjk.com/software/taag/
		        {
		        	[[┏┓┓              ┓                     ]],
		            [[┃┓┃┏┓┏┓┓┏  ╋┏┓  ╋┣┓┏┓                  ]],
		            [[┗┛┗┗┛┛ ┗┫  ┗┗┛  ┗┛┗┗                   ]],
		            [[┳┓•  •  ┛   ┏┓                         ]], 
		            [[┃┃┓┓┏┓┏┓┏┓  ┃ ┏┓┏┓┏┓┏┏┓                ]], 
		            [[┻┛┗┗┛┗┛┗┗   ┗┛┗┛┛ ┣┛┛┗ ╻               ]], 
		            [[┏┓┓   ┳┓      ┓   ┛     ┏  ┳  ┏•  •    ]], 
		            [[┃┃┣┓  ┣┫┏┓┏┓┏┓┃┏┏┓┏┓  ┏┓╋  ┃┏┓╋┓┏┓┓╋┏┓┏]],
		            [[┗┛┛┗  ┻┛┛ ┗ ┗┻┛┗┗ ┛   ┗┛┛  ┻┛┗┛┗┛┗┗┗┗ ┛]],
		        },


    }

    local header = headers[math.random(#headers)]
    local hlarr = {{}}
    local lines = # header
    for x=1,lines do
      hlarr[x] = {{"Repeat", 0, header[x]:len()}}
    end
	  return {

				{ type = "padding", val = 1 },
				{
  					type = "text",
        		val = header,
				    opts = { hl = hlarr, position = "center" },
				},

				{ type = "padding", val = 3 },
      	{
				    type = "group",
		  	    val = mru(),
				    opts = { spacing = 0  },
				},
				{ type = "padding", val = 2 },
		}
	end

	vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
	]])

  require("alpha").setup {
		  layout = layout(),
		  opts = {
		    autostart = true,
		    setup = function()
		      vim.api.nvim_create_autocmd("User", {
		        pattern = "AlphaReady",
		        desc = "Disable status and tabline for alpha",
		        callback = function()
		          vim.go.laststatus = 0
		          vim.opt.showtabline = 0
		        end,
		      })
		      vim.api.nvim_create_autocmd("BufUnload", {
		        buffer = 0,
		        desc = "Enable status and tabline after alpha",
		        callback = function()
		          vim.go.laststatus = 3
		          vim.opt.showtabline = 2
		        end,
		      })
		    end,
		    margin = 5,
		  },
		}


