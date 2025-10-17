M = {}

function M.is_executable_available(name)
    local command = string.format("command -v %s > /dev/null 2>&1", name)
    return os.execute(command) == 0
end

return M
