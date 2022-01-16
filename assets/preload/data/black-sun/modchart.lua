function start(song) -- arguments, the song name
  for i=0,5 do -- fade out the first 6 receptors (the ai receptors)
    tweenPos(i, _G['defaultStrum'..i..'X'] - 1000, 0, 0.01)
  end
end

-- this gets called every frame
function update(elapsed) -- arguments, how long it took to complete a frame

end

-- this gets called every beat
function beatHit(beat) -- arguments, the current beat of the song
    
end

-- this gets called every step
function stepHit(step) -- arguments, the current step of the song (4 steps are in a beat)

end