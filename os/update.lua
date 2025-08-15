-- update.lua
os.loadAPI("/os/gui.lua")
os.loadAPI("/os/window.lua")

local githubVersionURL = "https://raw.githubusercontent.com/TheMFCRaft1/VOS-CC-Tweaked/version.txt"
local localVersionFile = "/os/version.txt"

local function readLocalVersion()
    if fs.exists(localVersionFile) then
        local f = fs.open(localVersionFile, "r")
        local v = f.readAll()
        f.close()
        return v
    end
    return "0.0.0"
end

local function fetchRemoteVersion()
    if http then
        local response = http.get(githubVersionURL)
        if response then
            local v = response.readAll()
            response.close()
            return v
        end
    end
    return nil
end

local function downloadUpdate()
    local files = {
        "main.lua",
        "gui.lua",
        "window.lua",
        "events.lua"
    }

    for _, f in ipairs(files) do
        local url = "https://raw.githubusercontent.com/TheMFCRaft1/VOS-CC-Tweaked/main/" .. f
        local r = http.get(url)
        if r then
            local data = r.readAll()
            r.close()
            local file = fs.open("/os/"..f, "w")
            file.write(data)
            file.close()
        end
    end
end

function checkUpdate()
    local localVersion = readLocalVersion()
    local remoteVersion = fetchRemoteVersion()

    if remoteVersion and remoteVersion ~= localVersion then
        -- Update-Fenster erstellen
        local updateWin = window.create(5, 5, 40, 10, "Update verfügbar")
        updateWin.draw = function(self)
            gui.text(self.x+1, self.y+2, "Neue Version: "..remoteVersion, colors.white, colors.gray)
            gui.text(self.x+1, self.y+4, "Lokale Version: "..localVersion, colors.white, colors.gray)
            gui.button(self.x+5, self.y+6, 12, 1, "Jetzt updaten", function()
                downloadUpdate()
                gui.text(self.x+1, self.y+8, "Update abgeschlossen!", colors.green, colors.gray)
            end)
        end
        table.insert(window.list, updateWin)
    end
end
