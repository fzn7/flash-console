## Get FlashVars ##
_assuming your commandline scope is Stage or a DisplayObject_
```
$C.inspect(loaderInfo.parameters)
```

## Reduce frame rate ##
_assuming your commandline scope is Stage or a DisplayObject_
(replace `5` with your own choice)
```
stage.frameRate = 5
```


## Log key presses ##
_assuming your commandline scope is Stage or a DisplayObject_
```
stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, $C.log)
```
Key presses while focused on command line will be ignored as it has `Event.stopPropagation()`.


## Copy to clipboard ##
(replace `$returned` with a variable/string you want to save)
```
flash.system.System.setClipboard($returned)
```


## Maths ##

  * Simple: `10-(5/2)`
  * Assignment: `stage.frameRate *= 1.5`
  * Advanced: `(90*Math.PI)/180` - _90 degree in radians_
  * Bitwise:`2761 & 234`