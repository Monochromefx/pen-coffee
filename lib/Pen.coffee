log = console.log
doc = document
pro = (arg) -> arg::
pro(String).getInput = (reg) ->
  str = this
  a = undefined
  while `(a = reg.exec(str))` isnt null
    if a.index is reg.lastIndex
      reg.lastIndex++
    return a
if doc.body?
  body = doc.body
else
  alert "Body is not defined in the html document."
if doc.head?
  head = doc.head
else
  alert "Head is not defined in the html document."

class Pen
  constructor: (@auto) ->
  create: (el) ->
    return doc.createElement el
  getIdOf: (el) ->
    return doc.getElementById el
  getNameOf: (el) ->
    return doc.getElementsByName el
  getClassOf: (el) ->
    return doc.getElementsByClassName el
  getTagsOf: (el) ->
    return doc.getElementsByTagName el
  select: (txt) ->
    return doc.querySelector txt
  selectAll: (txt) ->
    return doc.querySelectorAll txt
  checker: () ->
    if @auto is on
      return on
    else
      return off
  autoAppend: (el) ->
    if @checker() is on
      body.appendChild el
      return el
    else
      return el
  oEl: (el, oel) ->
    if not oel
      return el
    else
      if typeof oel is 'function'
        el.appendChild oel(el)
      else
        el.appendChild oel
        return el
  createAppend: (el) ->
    el = @create el
    @autoAppend el

  checkElement: (el) ->
    if typeof el is 'string'
      el = @select el
      return el


  ###
  # ^^^^^
  # Helpers
  # -------
  # Handlers
  # vvvvv
  ###


  objHandler: (el, obj, txt) ->
    el.innerHTML = txt if txt isnt null
    switch obj
      when obj['title'] then el.setAttribute "title", obj['title']
      when obj['style'] then el.setAttribute "style", obj['style']
      when obj['id'],obj['identification'] then el.setAttribute "id", obj['id'] or obj['identification']
      when obj['click'], obj['onclick'] then el.setAttribute "onclick", obj['click'] or obj['onclick']
      when obj['class'], obj['classes'] then el.setAttribute "class", obj['class'] or obj['classes']
    return el

  areaHandler: (el, obj, txt) ->
    el = @objHandler el, obj, txt
    el.width = if obj.width? then obj.click else ''
    el.height = if obj.height? then obj.height else ''
    return el

  inputHandler: (el,obj,type,txt) ->
    el = @objHandler el, obj
    el.value = if txt? then txt else ''
    el.type = if obj.type? then obj.type else ''
    return el

  linkAndSourceHandler: (el, obj, txt, type) ->
    el = @objHandler el, obj, txt
    if type.match /link|href/gi
      el.href = if obj.href? then obj.href else throw new Error "'href' must be defined in the object parameter"
    else if type.match /source|src/gi
      el.src = if obj.src? then obj.src else throw new Error "'src' must be defined in the object parameter"
    return el

  dividerHandler: (el) ->
    return el

  automaticHandler: (el, txt, obj, oel) ->
    el = @create el
    el = @objHandler el, obj, txt
    if oel
      el = @oEl el, oel
    @autoAppend el

  automaticLinkHandler: (el, type, txt, obj, oel) ->
    el = @create el
    el = @linkAndSourceHandler el, obj, txt, type
    if oel
      el = @oEl el, oel
    @autoAppend el

  automaticInputHandler: (el, type, txt, obj) ->
    el = @create el
    el = @inputHandler el, obj, type, txt
    @autoAppend el

  automaticAreaHandler: (el, txt, obj) ->
    el = @create el
    el = @areaHandler el, obj, txt
    @autoAppend el

  automaticDividerHandler: (el) ->
    el = @create el
    el = @dividerHandler el
    @autoAppend el

  ###
  # ^^^^^
  # Handlers
  # -------
  # Methods
  # vvvvv
  ###

  Html: (el, txt) ->
    el = @checkElement el
    if typeof txt is 'object'
      JSON.parse txt
    if typeof txt is 'function'
      txt = txt(el)
    el.innerHTML = txt
    return el

  Css: (el, txt) ->
    el = @checkElement el
    el.style = txt
    return el

  Id: (el, txt) ->
    el = @checkElement el
    el.id = txt
    return el

  Type: (el, txt) ->
    el = @checkElement el
    el.type = txt
    return el

  Append: (el, el2) ->
    el = @checkElement el
    el.appendChild el2
    return el

  ###
  # ^^^^^
  # Methods
  # -------
  # Tags
  # vvvvv
  ###


  p: (txt, obj) ->
    @automaticHandler 'p', txt, obj

  div: (obj, txt, oel) ->
    @automaticHandler 'div', txt, obj, oel

  span: (obj, txt, oel) ->
    @automaticHandler 'span', txt, obj, oel

  a: (obj, txt, oel) ->
    @automaticLinkHandler 'a', "href", txt, obj, oel

  ul: (obj, txt, oel) ->
    @automaticHandler 'ul', txt, obj, oel

  li: (obj, txt, oel) ->
    @automaticHandler 'li', txt, obj, oel

  code: (obj, txt) ->
    @automaticHandler 'code', txt, obj

  pre: (obj, txt) ->
    @automaticHandler 'pre', txt, obj

  label: (obj, txt) ->
    @automaticHandler 'label', txt, obj

  legend: (obj, txt) ->
    @automaticHandler 'legend', txt, obj

  form: (obj, txt, oel) ->
    @automaticHandler 'form', txt, obj, oel

  fieldset: (obj, txt, oel) ->
    @automaticHandler 'fieldset', txt, obj, oel

  input: (obj, type, txt) ->
    @automaticInputHandler 'input', type, txt, obj

  button: (obj, txt) ->
    @automaticHandler 'button', txt, obj

  abbr: (obj,txt) ->
    @automaticHandler 'abbr', txt, obj

  style: (txt, obj) ->
    @automaticHandler 'style', txt, obj

  script: (txt, obj) ->
    @automaticHandler 'script', txt, obj

  canvas: (obj, txt) ->
    @automaticHandler 'canvas', txt, obj

  br: () ->
    @automaticDividerHandler 'br'

  ###
  # ^^^^^
  # Tags
  # -------
  # Methods part 2
  # vvvvv
  ###

  write: (txt) ->
    para = @create 'p'
    txt = txt.replace /;|`n|\\n/gi, '.<br>'

    ### links ###
    ###
    # So this part is for handling link emebeds if you want to do so
    ###
    ### ###

    reg = /\((.*?)\)\[(.*?)\]/gi
    link = txt.getInput(reg)[1]
    ### for the links input part ###
    cover = txt.getInput(reg)[2]
    ### for the cover of the link ###
    txt = txt.replace reg, "<a href='#{link}'>#{cover}</a>"

    ###
    # mini doc on the getInput for the string property
    # getInput is not part of the standard for strings
    # is a method I made for myself to be able to access what was returned in an easier way without having to build a callback function
    # and it is a way to also help with a lot of other things.
    # this is just one of the ways to do it
    ###

    para.innerHTML = txt
