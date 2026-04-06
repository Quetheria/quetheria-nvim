if vim.fn.executable('julia') ~= 1 then
  return
end

local root_files = {
  '*.jl',
  '.git',
}

require("lspconfig").julials.setup{}

--local cmd = { "julia", "--startup-file=no", "--history-file=no", "-e",
--  [[
--    using Pkg
--    Pkg.instantiate()
--    using LanguageServer
--    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
--    project_path = let
--        dirname(something(
--            ## 1. Finds an explicitly set project (JULIA_PROJECT)
--            Base.load_path_expand((
--                p = get(ENV, "JULIA_PROJECT", nothing);
--                p === nothing ? nothing : isempty(p) ? nothing : p
--            )),
--            ## 2. Look for a Project.toml file in the current working directory,
--            ##    or parent directories, with $HOME as an upper boundary
--            Base.current_project(),
--            ## 3. First entry in the load path
--            get(Base.load_path(), 1, nothing),
--            ## 4. Fallback to default global environment,
--            ##    this is more or less unreachable
--            Base.load_path_expand("@v#.#"),
--        ))
--    end
--    @info "Running language server" VERSION pwd() project_path depot_path
--    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
--    server.runlinter = true
--    run(server)
--  ]] }
--local server_path = vim.fn.system 'julia --startup-file=no -q -e \'print(Base.find_package("LanguageServer"))\''
--local new_cmd = vim.deepcopy(cmd)
--table.insert(new_cmd, 2, '--project=' .. server_path:sub(0, -19))
--
--vim.lsp.start {
--  name = 'julia',
--  cmd = new_cmd,
--  filetypes = { "julia" },
--  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
--  capabilities = require('user.lsp').make_client_capabilities(),
--}
