-- main.lua
os.loadAPI("/os/gui.lua")
os.loadAPI("/os/window.lua")
os.loadAPI("/os/events.lua")

term.setBackgroundColor(colors.black)
term.clear()

-- Beispiel-Fenster erstellen
local mainWin = window.create(5, 5, 25, 10, "Willkommen")
mainWin.draw = function(self)
    gui.text(self.x+1, self.y+2, "Hallo Welt!", colors.white, colors.gray)
end

table.insert(window.list, mainWin)

-- Hauptschleife
while true do
    window.redrawAll()
    local e = {os.pullEvent()}
    events.handle(e)
end
