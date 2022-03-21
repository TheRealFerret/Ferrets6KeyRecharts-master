function start(song) 
  
end
function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorAngle(id)
end
function update (elapsed)
    
  
end
function stepHit(step) 
    if noTriggerFlip then

    else
        ---makes you seethe lole  
        if curStep == 1797 then 
            --hide em 
            setActorAlpha(0,11)
            setActorAlpha(0,10)
            setActorAlpha(0,9)
            setActorAlpha(0,8)
            setActorAlpha(0,7)
            setActorAlpha(0,6)
        end
        if curStep == 1802 then
            --x's
            setActorX(defaultStrum6X,11)
            setActorX(defaultStrum7X,10)
            setActorX(defaultStrum8X,9)
            setActorX(defaultStrum9X,8)
            setActorX(defaultStrum10X,7)
            setActorX(defaultStrum11X,6)
            for i=6,11 do
                tweenAngle(i,_G['defaultStrum'..i..'Angle']+180,0.000001,'setDefault')          
            end
        end
        if curStep == 1820 then
            --show em
            setActorAlpha(100,11)
            setActorAlpha(100,10)
            setActorAlpha(100,9)
            setActorAlpha(100,8)
            setActorAlpha(100,7)
            setActorAlpha(100,6)
        
        end
    end
end      
  

function beatHit(beat) 

end



