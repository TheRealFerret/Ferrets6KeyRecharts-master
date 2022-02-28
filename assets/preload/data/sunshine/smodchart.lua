function start(song) -- arguments, the song name

end

-- this gets called every frame
function update(elapsed) -- arguments, how long it took to complete a frame
  if curStep >= 588 and curStep < 859 then
    for i=0,5 do -- fade out the first 6 receptors (the ai receptors)
	  	tweenPos(i, _G['defaultStrum'..i..'X'] - 1000, 0, 0.01)
    end
  end

  if curStep >= 860 then
    for i=0,5 do -- fade out the first 6 receptors (the ai receptors)
	  	tweenPos(i, _G['defaultStrum'..i..'X'] + 0, 50, 0.01)
    end
  end
end

-- this gets called every beat
function beatHit(beat) -- arguments, the current beat of the song
    
end

-- this gets called every step
function stepHit(step) -- arguments, the current step of the song (4 steps are in a beat)

end