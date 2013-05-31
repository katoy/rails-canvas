$ ->

  class MyCanvas

    PI2 = Math.PI * 2

    constructor: (@canvas)->
      @ctx = @canvas.getContext('2d')
      @lineWidth = 10
      @prevPos = {x:0, y:0}
      @mouse_down = false
      @historyData = []
      @addHistory()

    setMouseState:  (flag) ->
      @addHistory() if @mouse_down is true and flag is false
      @mouse_down = flag
    setLineWidth: (val) -> @lineWidth = val
    getLineWidth: -> @lineWidth
    setColor: (@color) ->
      @ctx.strokeStyle = @color
      @ctx.fillStyle = @color
    getColor: -> @color

    addHistory: ->
      @historyData.slice(@historyIdx + 1)
      @historyData.push @ctx.getImageData(0, 0, @canvas.width, @canvas.height)
      @historyIdx = @historyData.length - 1

    showHistoryAt: (idx = @historyIdx)->
      if (idx < 0 or idx >= @historyData.length)
        false
      else
        @ctx.putImageData(@historyData[idx], 0, 0)
        @historyIdx = idx
        true

    showHistory: (step) -> @showHistoryAt(@historyIdx + step)
  
    clear: ->
      @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
      @addHistory()
      null

    save: ->
      url = @canvas.toDataURL()
      $.post '/pictures', {data: url}

    mousedown: (e) ->
      @mouse_down = true
      @prevPos = @getPointPosition(e)
      @putPoint(@prevPos)

    mousemove: (e) ->
      return unless @mouse_down
      curPos = @getPointPosition(e)
      @drawLine(@prevPos, curPos)
      @putPoint(curPos)
      @prevPos = {x:curPos.x, y:curPos.y}

    getPointPosition: (e) ->
      x: e.pageX - canvas.offsetLeft
      y: e.pageY - canvas.offsetTop

    putPoint: (pos, width = @lineWidth, color = @color) ->
      @ctx.beginPath()
      @ctx.arc(pos.x, pos.y, width / 2.0, 0, PI2, false)
      @ctx.fillStyle = color
      @ctx.fill()
      @ctx.closePath()

    drawLine: (posS, posE, lineWidth = @lineWidth, color = @color) ->
      @ctx.lineWidth = lineWidth
      @ctx.beginPath()
      @ctx.moveTo(posS.x, posS.y)
      @ctx.lineTo(posE.x, posE.y)
      @ctx.strokeStyle = color
      @ctx.stroke()
      @ctx.closePath()

  canvas = $('#draw-area')[0]
  myCanvas = new MyCanvas(canvas)

  $(canvas).mousedown (e) -> myCanvas.mousedown(e)
  $(canvas).mousemove (e) -> myCanvas.mousemove(e)
  $(canvas).mouseup   (e) -> myCanvas.setMouseState(false)
  $(canvas).mouseout  (e) -> myCanvas.setMouseState(false)

  # 線の太さ
  $("#show-pen-width").text(myCanvas.getLineWidth())
  $("#pen-width-slider").change ->
    v = $(@).val()
    myCanvas.setLineWidth(v)
    $("#show-pen-width").text(myCanvas.getLineWidth())

  # 線の色
  red_slider = $("#pen-color-red-slider")
  green_slider = $("#pen-color-green-slider")
  blue_slider = $("#pen-color-blue-slider")
  alpha_slider = $("#pen-color-alpha-slider")
  preview_color = $("#preview-color")

  setColor = ->
    color = "rgba(#{red_slider.val()},#{green_slider.val()},#{blue_slider.val()},#{alpha_slider.val() / 100})"
    myCanvas.setColor(color)
    preview_color.css('background-color', color)

  red_slider.change ->
    setColor()
    $("#show-pen-red").text($(@).val())
  green_slider.change ->
    setColor()
    $("#show-pen-green").text($(@).val())
  blue_slider.change ->
    setColor()
    $("#show-pen-blue").text($(@).val())
  alpha_slider.change ->
    setColor()
    $("#show-pen-alpha").text(($(@).val() / 100).toFixed(2))

  # 消去
  $("#clear-button").click -> myCanvas.clear()
  # undo
  $("#undo-button").click -> myCanvas.showHistory(-1)
  # undo
  $("#redo-button").click -> myCanvas.showHistory(1)
  # 保存
  # $("#save-button").click -> myCanvas.save()
