var Start,body,contextmenu,dropdown,head,header,load,log;log="iphone"===navigator.platform.toLowerCase()?alert:console.log,({body:body,head:head}=document),load=pen("<p>").id("loader"),pen(body).append(load),load.html("loading..."),(dropdown=function(n="button"){var t,e,o;if(!(this instanceof dropdown))return new dropdown(n);if(n instanceof dropdown)for(t=0,e=n.length;t<e;t++)this[o=n[t]]=n[o];else this.links={},this.container=pen("<div>").class("dropdown"),this.button=pen("<button>").class("dropdown-button").html(n),this.content=pen("<div>").class("dropdown-content"),this.container.append(this.button,this.content)}).fn=dropdown.prototype={constructor:dropdown},dropdown.prototype.addLink=function(n,t,e="no description"){var o,a;return o=pen("<a>").class("dropdown-content-link").html(n+"<br>").href(t),pen("<span>").class("dropdown-content-link-location").html(t+"<br>").appendTo(o),(e=pen("<span>").class("dropdown-content-link-location").html(e)).appendTo(o),a=pen("<hr>").class("dropdown-content-divider"),this.links[n]={},this.links[n].el=o,this.links[n].hr=a,this.content.append(o,a),this},dropdown.prototype.removeLink=function(n,t=!1){return this.links[n].el.remove(),!0===t&&delete this.links[n],this},dropdown.prototype.deployTo=dropdown.prototype.deploy=function(n){return this.container.appendTo(n),this},dropdown.prototype.css=dropdown.prototype.style=function(n=String,...t){return this[n].css([...t]),this},contextmenu={commands:{},menu:pen("<div>").class("contextmenu").attr("align","center"),add:function(n,t,e="button",o){var a,d,r;return o=`<${o}>`,d=contextmenu,a=pen("<hr>").class("contextmenu-divider"),e.match(/link/gi)?r=pen("<a>").href(t).html(n).class("contextmenu-command link"):e.match(/button/gi)?r=pen("<span>").on("click",t).html(n).class("contextmenu-command"):e.match(/custom/gi)&&(r="function"===type(t)?pen(o).on("click",t).html(n).class("contextmenu-command custom"):pen(o).href(t).html(n).class("contextmenu-command custom")),d.commands[n]={},d.commands[n].el=r,d.commands[n].hr=a,d.menu.append(d.commands[n].el,d.commands[n].hr),d},removeCommand:function(n,t=!1){var e;return(e=contextmenu).commands[n].el.remove(),e.commands[n].hr.remove(),!0===t&&delete e.commands[n],e},remove:function(){var n,t;t=contextmenu;for(n in t.commands)t.removeCommand(n);return t},init:function(n){var t,e;(e=contextmenu).menu.css({top:`${n.clientY}px`,left:`${n.clientX}px`});for(t in e.commands)e.menu.append(e.commands[t].el.element,e.commands[t].hr.element);return addEventListener("click",e.remove,{once:!0}),pen(body).append(e.menu),e}},header={buttons:{},head:pen("<div>").class("header"),title:pen("<span>").class("title Lil").html(document.title),add:function(n,t,e="button",o){var a,d;return o=`<${o}>`,console.log(n),a=header,t instanceof dropdown?(d=pen("<span>").html(t.container.el.outerHTML).class("header-button custom Ril"),a.buttons[n]=d,a):(e.match(/link/gi)?d=pen("<a>").href(t).html(n).class("header-button link Ril"):e.match(/button/gi)?d=pen("<span>").on("click",t).html(n).class("header-button Ril"):e.match(/custom/gi)&&(d="function"===type(t)?pen(o).on("click",t).html(n).class("header-button custom Ril"):pen(o).href(t).html(n).class("header-button custom Ril")),a.commands[n]=d,a)},removeButton:function(n,t){var e;return e=header,pen(e.buttons[n]).remove(),!0===t&&delete e.buttons[n],e},init:function(){var n,t,e,o,a;a=header,pen(a.head).append(a.title);for(o in a.buttons)pen(a.head).append(a.buttons[o]);for(pen(body).append(a.head),n=[],t=e=0;e<=3;t=++e)n[t]=pen("<br>").el,body.insertBefore(n[t],body.childNodes[0]);return a}},Start=function(n){var t,e,o,a,d,r;contextmenu.add("reload",function(n){n.preventDefault(),pen(load).html("reloading..."),location.reload()}).add("go back",function(n){n.preventDefault(),pen(load).html("going back..."),history.back()}).add("go forward",function(n){n.preventDefault(),pen(load).html("going foward..."),history.forward()}).add("github repo",function(n){n.preventDefault(),pen(load).html("going to github repo..."),location.href="http://github.com/Monochromefx/pen"}),addEventListener("contextmenu",function(n){var t;if("tagName"in(t=n.path[0]))switch(t.tagName.toLowerCase()){case"img":contextmenu.add("go to href",pen(t).src(),"link")}n.preventDefault(),contextmenu.init(n)}),r="https://github.com/Monochromefx",d=dropdown("projects").addLink("Pen",`${r}/pen`,"This project").addLink("Schem",`${r}/schem`,"a multipurpose electron app").addLink("Meso",`${r}/meso`,"a lightweight javascript in-browser source code editor"),header.add("pjdropdown",d),header.init(),a=function(n){pen(this).html("<br>want to remove this message?, if so just click me",!0)},t=`load took ${Date.now()-timestamp} seconds`,o=function(n){pen(this).html(t)},e=function(n){pen(this).remove()},load.html(t),log(t),load.on("mouseover",a),load.on("mouseout",o),load.on("click",e)},pen(document).ready(function(n){return Start(n)});