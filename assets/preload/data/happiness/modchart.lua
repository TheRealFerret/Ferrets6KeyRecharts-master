function start (song)
    if middlescroll then
        tweenFadeOut('camHUD',0,0.1)
        tweenFadeOut('boyfriend',0,0.1)
        tweenFadeOut('camNotes',0,0.1)
    else
        setActorX(defaultStrum0X,6,'setDefault')
        setActorX(defaultStrum1X,7,'setDefault')
        setActorX(defaultStrum2X,8,'setDefault')
        setActorX(defaultStrum3X,9,'setDefault')
        setActorX(defaultStrum4X,10,'setDefault')
        setActorX(defaultStrum5X,11,'setDefault')

        setActorX(defaultStrum6X,0,'setDefault')
        setActorX(defaultStrum7X,1,'setDefault')
        setActorX(defaultStrum8X,2,'setDefault')
        setActorX(defaultStrum9X,3,'setDefault')
        setActorX(defaultStrum10X,4,'setDefault')
        setActorX(defaultStrum11X,5,'setDefault')
        tweenFadeOut('camHUD',0,0.1)
        tweenFadeOut('boyfriend',0,0.1)
        tweenFadeOut('camNotes',0,0.1)
    end
end
function update(elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60) 
end

function stepHit (step)
    if step == 320 then
        tweenFadeIn('camHUD',1,10)
        tweenFadeIn('camNotes',1,10)
        tweenFadeIn('boyfriend',1,10)
    end
end