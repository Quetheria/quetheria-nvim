local utils = require("alpha.utils")

local if_nil = vim.F.if_nil
local fnamemodify = vim.fn.fnamemodify
local filereadable = vim.fn.filereadable

local leader = "SPC"
-- some snippets from https://github.com/BeyondMagic/lovemii/blob/3763a6dfe2986081e13de14f0324eb1a72ace020/_config/nvim/lua/screen.lua 
-- and lots of things from https://github.com/dtr2300/nvim/blob/main/lua/config/plugins/alpha.lua
-- also headers include references to Tom Bloom's Kill Six Billion Demons, 
-- and some ascii cats from  https://user.xmission.com/~emailbox/ascii_cats.htm

-- highlight group definitions
vim.api.nvim_set_hl(0, "buttoncore", {fg = '#c678dd', bold=true})

vim.api.nvim_set_hl(0, "buttonwrap", {fg = '#cba6f7'})



local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "left",
        shortcut = "[" .. sc .. "] ",
        cursor = 1,
        -- width = 50,
        align_shortcut = "left",
        hl_shortcut = { { "buttonwrap", 0, 1 }, { "buttoncore", 1, #sc + 1 }, { "buttonwrap", #sc + 1, #sc + 2 } },
        shrink_margin = false,
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local file_icons = {
    enabled = true,
    highlight = true,
    -- available: devicons, mini, to use nvim-web-devicons or mini.icons
    -- if provider not loaded and enabled is true, it will try to use another provider
    provider = "mini",
}

local function icon(fn)
    if file_icons.provider ~= "devicons" and file_icons.provider ~= "mini" then
        vim.notify("Alpha: Invalid file icons provider: " .. file_icons.provider .. ", disable file icons", vim.log.levels.WARN)
        file_icons.enabled = false
        return "", ""
    end

    local ico, hl = utils.get_file_icon(file_icons.provider, fn)
    if ico == "" then
        file_icons.enabled = false
        vim.notify("Alpha: Mini icons or devicons get icon failed, disable file icons", vim.log.levels.WARN)
    end
    return ico, hl
end

local function file_button(fn, sc, short_fn, autocd)
    short_fn = if_nil(short_fn, fn)
    local ico_txt
    local fb_hl = {}
    if file_icons.enabled then
        local ico, hl = icon(fn)
        local hl_option_type = type(file_icons.highlight)
        if hl_option_type == "boolean" then
            if hl and file_icons.highlight then
                table.insert(fb_hl, { hl, 0, #ico })
            end
        end
        if hl_option_type == "string" then
            table.insert(fb_hl, { file_icons.highlight, 0, #ico })
        end
        ico_txt = ico .. "  "
    else
        ico_txt = ""
    end
    local cd_cmd = (autocd and " | cd %:p:h" or "")
    local file_button_el = button(sc, ico_txt .. short_fn, "<cmd>e " .. vim.fn.fnameescape(fn) .. cd_cmd .. " <CR>")
    local fn_start = short_fn:match(".*[/\\]")
    if fn_start ~= nil then
        table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
    end
    file_button_el.opts.hl = fb_hl
    return file_button_el
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
    ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
    end,
    autocd = false
}

--- @param start number
--- @param cwd string? optional
--- @param items_number number? optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
    opts = opts or mru_opts
    items_number = if_nil(items_number, 10)
    local oldfiles = {}
    for _, v in pairs(vim.v.oldfiles) do
        if #oldfiles == items_number then
            break
        end
        local cwd_cond
        if not cwd then
            cwd_cond = true
        else
            cwd_cond = vim.startswith(v, cwd)
        end
        local ignore = (opts.ignore and opts.ignore(v, utils.get_extension(v))) or false
        if (filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
        end
    end

    local tbl = {}
    for i, fn in ipairs(oldfiles) do
        local short_fn
        if cwd then
            short_fn = fnamemodify(fn, ":.")
        else
            short_fn = fnamemodify(fn, ":~")
        end
        local file_button_el = file_button(fn, tostring(i + start - 1), short_fn, opts.autocd)
        tbl[i] = file_button_el
    end
    return {
        type = "group",
        val = tbl,
        opts = {},
    }
end

local function mru_title()
    return "mru " .. vim.fn.getcwd()
end

    	math.randomseed( os.time() )
		local headers = {
		          {
		                [[  \    /\]],
		                [[   )  ( ')]],
		                [[   (  /  )]],
		                [[jgs \(__)|]],
	            },
	            {
                [[((      /|_/|]],
                [[ \\.._.'  , ,\]],
                [[ /\ | '.__ v /]],
                [[(_ .   /   "]],
                [[ ) _)._  _ /]],
                [['.\ \|( / ( mrf]],
                [[  '' ''\\ \\]],
                },
                -- you *gotta* go to the moon
                {
                [[Consider reading popular webcomic]],
                [[Kill Six Billion Demons by ABBADON ]],
                [[-- Moon Wizard Cat]],
                [[                                               ]],
                [[            *     ,MMM8&&&.            *       ]],
                [[                  MMMM88&&&&&    .             ]],
                [[                 MMMM88&&&&&&&                 ]],
                [[     *           MMM88&&&&&&&&                 ]],
                [[             ^   MMM88&&&&&&&&                 ]],
                [[            / \  'MMM88&&&&&&'                 ]],
                [[           /   \   'MMM8&&&'      *     _       ]],
                [[        __/     \__                     \\      ]],
                [[         =) ^Y^ (=   |\_/|              ||    ']],
                [[          \  ^  /    )a a '._.-""""-.  //      ]],
                [[           )=*=(    =\\T_= /    ~  ~  \//       ]],
                [[          /     \     `"`\\   ~   / ~  /        ]],
                [[          |     |         |~   \\ |  ~/         ]],
                [[         /| | | |\         \  ~/- \ ~\         ]],
                [[         \| | |_|/|        || |  // /`         ]],
                [[  jgs_/\_//_// __//\_/\_/\_((_|\((_//\_/\_/\_  ]],
                [[  |  |  |  | \_) |  |  |  |  |  |  |  |  |  |  ]],
                [[  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ]],
                [[  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ]],
                [[  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ]],
                [[  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ]],
                },
                {
                [[     /\__/\          ]],
                [[    /`    '\         ]],
                [[  === 0  0 ===       ]],
                [[    \  --  /         ]],
                [[   /        \        ]],
                [[  /          \       ]],
                [[ |            |      ]],
                [[  \  ||  ||  /       ]],
                [[   \_oo__oo_/#######o]],
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

    local headerfunc = function()
	    local header = headers[math.random(#headers)]
	    local hlarr = {{}}
	    local lines = # header
	    for x=1,lines do
	      hlarr[x] = {{"Repeat", 0, header[x]:len()}}
	    end
	    return   {
	       type = "text",
	       val = header,
	       opts = {
		       shrink_margin = false,
		       hl = hlarr,
		       position = "center" },
	      	     }, lines
	end
local header, hlines = headerfunc()
local section = {
    header = header,
    top_buttons = {
        type = "group",
        val = {
            button("e", "new file", "<cmd>ene <cr>"),
        },
    },
    -- note about mru: currently this is a function,
    -- since that means we can get a fresh mru
    -- whenever there is a dirchanged. this is *really*
    -- inefficient on redraws, since mru does a lot of i/o.
    -- should probably be cached, or maybe figure out a way
    -- to make it a reference to something mutable
    -- and only mutate that thing on dirchanged
    mru = {
        type = "group",
        val = {
            { type = "padding", val = 1 },
            { type = "text", val = "mru", opts = { hl = "Repeat" } },
            { type = "padding", val = 1 },
            {
                type = "group",
                val = function()
                    return { mru(10) }
                end,
            },
        },
    },
    mru_cwd = {
        type = "group",
        val = {
            { type = "padding", val = 1 },
            { type = "text", val = mru_title, opts = { hl = "Exception", shrink_margin = false } },
            { type = "padding", val = 1 },
            {
                type = "group",
                val = function()
                    return { mru(0, vim.fn.getcwd()) }
                end,
                opts = { shrink_margin = false },
            },
        },
    },
    bottom_buttons = {
        type = "group",
        val = {
            button("q", "quit", "<cmd>q <cr>"),
        },
    },
    footer = {
        type = "group",
        val = {},
    },
}


--TODO im not thinking about this right now
-- get number of vertical lines in alpha section
--[[
function Section_lines (count, tab)
  if not (tab["type"] ~= nil and tab["val"] ~= nil) then
    if tab.type == "text" then
      local _, lines = tab.val:gsub('\n', '\n')
      return lines
    end
    if tab.type == "group" then
      return count + Section_lines(count, tab.val)
    end

  elseif type(tab) ==  "string" then
    local _, lines = tab:gsub('\n', '\n')
    return lines
  else
    return 0
  end
end

local dyn_padding = function (seclist)
  local sum = 0
  for x=1,#seclist do
    sum = sum + Section_lines(0, seclist[x])
  end

  return 61 - sum

endocal section_lines = function(tab)
      
    end
  end

end
local dyn_padding = function (seclist)
  local sum = 0
  for x in seclist do
    sum = sum + section_lines(x)
  end

  return vim.fn.winheight - sum

end
--]]
local config = {
	layout = {
	  { type = "padding", val = 1 },
          section.header,
          -- TODO do this programmatically 
          { type = "padding", val = vim.fn.winheight(0) - 11 - 22 - hlines},
          section.top_buttons,
          section.mru_cwd,
          { type = "padding", val = 1},
          section.mru,
          section.bottom_buttons,
          section.footer,
	},
	opts = {
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
                  vim.api.nvim_create_autocmd('DirChanged', {
                  pattern = '*',
                  group = "alpha_temp",
                  callback = function ()
                      require('alpha').redraw()
                      vim.cmd('AlphaRemap')
                  end,
		  })
		end,
	margin = 5,
	},
}


require("alpha").setup(config)


