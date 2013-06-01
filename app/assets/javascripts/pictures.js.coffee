$ ->

  class MyCanvas

    PI2 = Math.PI * 2

    constructor: (@canvas)->
      @ctx = @canvas.getContext('2d')
      @lineWidth = 10
      @prevPos = {x:0, y:0}
      @mouse_down = false
      @historyData = [@ctx.getImageData(0, 0, @canvas.width, @canvas.height)]
      @historyIdx = @historyData.length - 1
      @color = '#000000'

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
      @historyData = @historyData.slice(0, @historyIdx + 1)
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
      null

    reload: (image) ->
      @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
      @ctx.drawImage(image, 0, 0)
      @addHistory()

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

  listPictures = (myCanvas) ->
      $.get '/pictures/list.txt', (result)->
        # console.log result
        ids = result.split(',')
        pictures = $("#pictures")
        pictures.empty()
        ids.forEach (id, i)->
          if parseInt(id, 10) > 0
            pictures.append("<img src=\"/images/#{id}.png\" class=\"pict_thumbnail\" />")
        thumb_pics = $("#pictures .pict_thumbnail")
        thumb_pics.click ->
          image = new Image()
          image.src = $(@).attr('src')
          image.onload = ->
            myCanvas.reload(image)
        thumb_pics.mouseenter ->
          $(@).addClass('pict_thumbnail-over')
        thumb_pics.mouseout ->
          $(@).removeClass('pict_thumbnail-over')
        null

  # ====================================
  canvas = $('#draw-area')[0]
  if canvas
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
      $("#pen").css("height", v)
      $("#pen").css("margin-top", 90 - v)
      $("#show-pen-width").text(myCanvas.getLineWidth())

    # 線の色
    $("#color-choice").change ->
      v = $(@).val()
      myCanvas.setColor(v)
      $("#pen").css("background-color", v)

    # 消去
    $("#clear-button").click -> myCanvas.clear()
    # undo
    $("#undo-button").click -> myCanvas.showHistory(-1)
    # undo
    $("#redo-button").click -> myCanvas.showHistory(1)
    # 保存
    $("#save-button").click ->
      myCanvas.save()
      listPictures(myCanvas)

    # 画像一覧
    listPictures(myCanvas)
