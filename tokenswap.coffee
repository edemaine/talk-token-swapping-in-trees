swapDuration = 400

###
initCircles = ->
  ## Remember original location of all circles
  for elt in document.querySelectorAll 'circle'
    continue if elt.hasAttribute 'data-cx'
    elt.setAttribute 'data-cx', elt.getAttribute 'cx'
    elt.setAttribute 'data-cy', elt.getAttribute 'cy'
###

timeline = null

animateSwaps = (swaps, reverse) ->
  #initCircles()
  swaps = swaps.split /\s+/
  swaps.reverse() if reverse
  centers = {}
  timeline?.finish()
  timeline = new SVG.Timeline
  for swap, count in swaps
    continue unless swap
    [i, j] = swap.split ','
    i = parseInt i
    j = parseInt j
    if isNaN(i) or isNaN(j)
      console.warn "Invalid swap #{swap}"
      continue
    ti = SVG "circle.t#{i}"
    tj = SVG "circle.t#{j}"
    continue unless ti? and tj?
    ti.timeline timeline
    tj.timeline timeline
    centers[i] ?= [ti.cx(), ti.cy()]
    centers[j] ?= [tj.cx(), tj.cy()]
    ## Swap
    [centers[i], centers[j]] = [centers[j], centers[i]]
    ti.animate(swapDuration, swapDuration, 'after').center centers[i]...
    tj.animate(swapDuration, -swapDuration, 'after').center centers[j]...

Reveal.on 'fragmentshown', (e) ->
  return unless e.fragment.classList.contains 'tokenswap'
  animateSwaps e.fragment.dataset.swaps, false

Reveal.on 'fragmenthidden', (e) ->
  return unless e.fragment.classList.contains 'tokenswap'
  animateSwaps e.fragment.dataset.swaps, true
