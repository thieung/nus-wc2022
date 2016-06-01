! function(a, b) {
    function c(b, c) {
        var e, f, g, h = b.nodeName.toLowerCase();
        return "area" === h ? (e = b.parentNode, f = e.name, b.href && f && "map" === e.nodeName.toLowerCase() ? (g = a("img[usemap=#" + f + "]")[0], !!g && d(g)) : !1) : (/input|select|textarea|button|object/.test(h) ? !b.disabled : "a" === h ? b.href || c : c) && d(b)
    }

    function d(b) {
        return a.expr.filters.visible(b) && !a(b).parents().andSelf().filter(function() {
            return "hidden" === a.css(this, "visibility")
        }).length
    }
    var e = 0,
        f = /^ui-id-\d+$/;
    a.ui = a.ui || {}, a.ui.version || (a.extend(a.ui, {
        version: "1.9.2",
        keyCode: {
            BACKSPACE: 8,
            COMMA: 188,
            DELETE: 46,
            DOWN: 40,
            END: 35,
            ENTER: 13,
            ESCAPE: 27,
            HOME: 36,
            LEFT: 37,
            NUMPAD_ADD: 107,
            NUMPAD_DECIMAL: 110,
            NUMPAD_DIVIDE: 111,
            NUMPAD_ENTER: 108,
            NUMPAD_MULTIPLY: 106,
            NUMPAD_SUBTRACT: 109,
            PAGE_DOWN: 34,
            PAGE_UP: 33,
            PERIOD: 190,
            RIGHT: 39,
            SPACE: 32,
            TAB: 9,
            UP: 38
        }
    }), a.fn.extend({
        _focus: a.fn.focus,
        focus: function(b, c) {
            return "number" == typeof b ? this.each(function() {
                var d = this;
                setTimeout(function() {
                    a(d).focus(), c && c.call(d)
                }, b)
            }) : this._focus.apply(this, arguments)
        },
        scrollParent: function() {
            var b;
            return b = a.ui.ie && /(static|relative)/.test(this.css("position")) || /absolute/.test(this.css("position")) ? this.parents().filter(function() {
                return /(relative|absolute|fixed)/.test(a.css(this, "position")) && /(auto|scroll)/.test(a.css(this, "overflow") + a.css(this, "overflow-y") + a.css(this, "overflow-x"))
            }).eq(0) : this.parents().filter(function() {
                return /(auto|scroll)/.test(a.css(this, "overflow") + a.css(this, "overflow-y") + a.css(this, "overflow-x"))
            }).eq(0), /fixed/.test(this.css("position")) || !b.length ? a(document) : b
        },
        zIndex: function(c) {
            if (c !== b) return this.css("zIndex", c);
            if (this.length)
                for (var d, e, f = a(this[0]); f.length && f[0] !== document;) {
                    if (d = f.css("position"), ("absolute" === d || "relative" === d || "fixed" === d) && (e = parseInt(f.css("zIndex"), 10), !isNaN(e) && 0 !== e)) return e;
                    f = f.parent()
                }
            return 0
        },
        uniqueId: function() {
            return this.each(function() {
                this.id || (this.id = "ui-id-" + ++e)
            })
        },
        removeUniqueId: function() {
            return this.each(function() {
                f.test(this.id) && a(this).removeAttr("id")
            })
        }
    }), a.extend(a.expr[":"], {
        data: a.expr.createPseudo ? a.expr.createPseudo(function(b) {
            return function(c) {
                return !!a.data(c, b)
            }
        }) : function(b, c, d) {
            return !!a.data(b, d[3])
        },
        focusable: function(b) {
            return c(b, !isNaN(a.attr(b, "tabindex")))
        },
        tabbable: function(b) {
            var d = a.attr(b, "tabindex"),
                e = isNaN(d);
            return (e || d >= 0) && c(b, !e)
        }
    }), a(function() {
        var b = document.body,
            c = b.appendChild(c = document.createElement("div"));
        c.offsetHeight, a.extend(c.style, {
            minHeight: "100px",
            height: "auto",
            padding: 0,
            borderWidth: 0
        }), a.support.minHeight = 100 === c.offsetHeight, a.support.selectstart = "onselectstart" in c, b.removeChild(c).style.display = "none"
    }), a("<a>").outerWidth(1).jquery || a.each(["Width", "Height"], function(c, d) {
        function e(b, c, d, e) {
            return a.each(f, function() {
                c -= parseFloat(a.css(b, "padding" + this)) || 0, d && (c -= parseFloat(a.css(b, "border" + this + "Width")) || 0), e && (c -= parseFloat(a.css(b, "margin" + this)) || 0)
            }), c
        }
        var f = "Width" === d ? ["Left", "Right"] : ["Top", "Bottom"],
            g = d.toLowerCase(),
            h = {
                innerWidth: a.fn.innerWidth,
                innerHeight: a.fn.innerHeight,
                outerWidth: a.fn.outerWidth,
                outerHeight: a.fn.outerHeight
            };
        a.fn["inner" + d] = function(c) {
            return c === b ? h["inner" + d].call(this) : this.each(function() {
                a(this).css(g, e(this, c) + "px")
            })
        }, a.fn["outer" + d] = function(b, c) {
            return "number" != typeof b ? h["outer" + d].call(this, b) : this.each(function() {
                a(this).css(g, e(this, b, !0, c) + "px")
            })
        }
    }), a("<a>").data("a-b", "a").removeData("a-b").data("a-b") && (a.fn.removeData = function(b) {
        return function(c) {
            return arguments.length ? b.call(this, a.camelCase(c)) : b.call(this)
        }
    }(a.fn.removeData)), function() {
        var b = /msie ([\w.]+)/.exec(navigator.userAgent.toLowerCase()) || [];
        a.ui.ie = !!b.length, a.ui.ie6 = 6 === parseFloat(b[1], 10)
    }(), a.fn.extend({
        disableSelection: function() {
            return this.bind((a.support.selectstart ? "selectstart" : "mousedown") + ".ui-disableSelection", function(a) {
                a.preventDefault()
            })
        },
        enableSelection: function() {
            return this.unbind(".ui-disableSelection")
        }
    }), a.extend(a.ui, {
        plugin: {
            add: function(b, c, d) {
                var e, f = a.ui[b].prototype;
                for (e in d) f.plugins[e] = f.plugins[e] || [], f.plugins[e].push([c, d[e]])
            },
            call: function(a, b, c) {
                var d, e = a.plugins[b];
                if (e && a.element[0].parentNode && 11 !== a.element[0].parentNode.nodeType)
                    for (d = 0; d < e.length; d++) a.options[e[d][0]] && e[d][1].apply(a.element, c)
            }
        },
        contains: a.contains,
        hasScroll: function(b, c) {
            if ("hidden" === a(b).css("overflow")) return !1;
            var d = c && "left" === c ? "scrollLeft" : "scrollTop",
                e = !1;
            return b[d] > 0 ? !0 : (b[d] = 1, e = b[d] > 0, b[d] = 0, e)
        },
        isOverAxis: function(a, b, c) {
            return a > b && b + c > a
        },
        isOver: function(b, c, d, e, f, g) {
            return a.ui.isOverAxis(b, d, f) && a.ui.isOverAxis(c, e, g)
        }
    }))
}(jQuery),
function(a, b) {
    var c = 0,
        d = Array.prototype.slice,
        e = a.cleanData;
    a.cleanData = function(b) {
        for (var c, d = 0; null != (c = b[d]); d++) try {
            a(c).triggerHandler("remove")
        } catch (f) {}
        e(b)
    }, a.widget = function(b, c, d) {
        var e, f, g, h, i = b.split(".")[0];
        b = b.split(".")[1], e = i + "-" + b, d || (d = c, c = a.Widget), a.expr[":"][e.toLowerCase()] = function(b) {
            return !!a.data(b, e)
        }, a[i] = a[i] || {}, f = a[i][b], g = a[i][b] = function(a, b) {
            return this._createWidget ? void(arguments.length && this._createWidget(a, b)) : new g(a, b)
        }, a.extend(g, f, {
            version: d.version,
            _proto: a.extend({}, d),
            _childConstructors: []
        }), h = new c, h.options = a.widget.extend({}, h.options), a.each(d, function(b, e) {
            a.isFunction(e) && (d[b] = function() {
                var a = function() {
                        return c.prototype[b].apply(this, arguments)
                    },
                    d = function(a) {
                        return c.prototype[b].apply(this, a)
                    };
                return function() {
                    var b, c = this._super,
                        f = this._superApply;
                    return this._super = a, this._superApply = d, b = e.apply(this, arguments), this._super = c, this._superApply = f, b
                }
            }())
        }), g.prototype = a.widget.extend(h, {
            widgetEventPrefix: f ? h.widgetEventPrefix : b
        }, d, {
            constructor: g,
            namespace: i,
            widgetName: b,
            widgetBaseClass: e,
            widgetFullName: e
        }), f ? (a.each(f._childConstructors, function(b, c) {
            var d = c.prototype;
            a.widget(d.namespace + "." + d.widgetName, g, c._proto)
        }), delete f._childConstructors) : c._childConstructors.push(g), a.widget.bridge(b, g)
    }, a.widget.extend = function(c) {
        for (var e, f, g = d.call(arguments, 1), h = 0, i = g.length; i > h; h++)
            for (e in g[h]) f = g[h][e], g[h].hasOwnProperty(e) && f !== b && (a.isPlainObject(f) ? c[e] = a.isPlainObject(c[e]) ? a.widget.extend({}, c[e], f) : a.widget.extend({}, f) : c[e] = f);
        return c
    }, a.widget.bridge = function(c, e) {
        var f = e.prototype.widgetFullName || c;
        a.fn[c] = function(g) {
            var h = "string" == typeof g,
                i = d.call(arguments, 1),
                j = this;
            return g = !h && i.length ? a.widget.extend.apply(null, [g].concat(i)) : g, h ? this.each(function() {
                var d, e = a.data(this, f);
                return e ? a.isFunction(e[g]) && "_" !== g.charAt(0) ? (d = e[g].apply(e, i), d !== e && d !== b ? (j = d && d.jquery ? j.pushStack(d.get()) : d, !1) : void 0) : a.error("no such method '" + g + "' for " + c + " widget instance") : a.error("cannot call methods on " + c + " prior to initialization; attempted to call method '" + g + "'")
            }) : this.each(function() {
                var b = a.data(this, f);
                b ? b.option(g || {})._init() : a.data(this, f, new e(g, this))
            }), j
        }
    }, a.Widget = function() {}, a.Widget._childConstructors = [], a.Widget.prototype = {
        widgetName: "widget",
        widgetEventPrefix: "",
        defaultElement: "<div>",
        options: {
            disabled: !1,
            create: null
        },
        _createWidget: function(b, d) {
            d = a(d || this.defaultElement || this)[0], this.element = a(d), this.uuid = c++, this.eventNamespace = "." + this.widgetName + this.uuid, this.options = a.widget.extend({}, this.options, this._getCreateOptions(), b), this.bindings = a(), this.hoverable = a(), this.focusable = a(), d !== this && (a.data(d, this.widgetName, this), a.data(d, this.widgetFullName, this), this._on(!0, this.element, {
                remove: function(a) {
                    a.target === d && this.destroy()
                }
            }), this.document = a(d.style ? d.ownerDocument : d.document || d), this.window = a(this.document[0].defaultView || this.document[0].parentWindow)), this._create(), this._trigger("create", null, this._getCreateEventData()), this._init()
        },
        _getCreateOptions: a.noop,
        _getCreateEventData: a.noop,
        _create: a.noop,
        _init: a.noop,
        destroy: function() {
            this._destroy(), this.element.unbind(this.eventNamespace).removeData(this.widgetName).removeData(this.widgetFullName).removeData(a.camelCase(this.widgetFullName)), this.widget().unbind(this.eventNamespace).removeAttr("aria-disabled").removeClass(this.widgetFullName + "-disabled ui-state-disabled"), this.bindings.unbind(this.eventNamespace), this.hoverable.removeClass("ui-state-hover"), this.focusable.removeClass("ui-state-focus")
        },
        _destroy: a.noop,
        widget: function() {
            return this.element
        },
        option: function(c, d) {
            var e, f, g, h = c;
            if (0 === arguments.length) return a.widget.extend({}, this.options);
            if ("string" == typeof c)
                if (h = {}, e = c.split("."), c = e.shift(), e.length) {
                    for (f = h[c] = a.widget.extend({}, this.options[c]), g = 0; g < e.length - 1; g++) f[e[g]] = f[e[g]] || {}, f = f[e[g]];
                    if (c = e.pop(), d === b) return f[c] === b ? null : f[c];
                    f[c] = d
                } else {
                    if (d === b) return this.options[c] === b ? null : this.options[c];
                    h[c] = d
                }
            return this._setOptions(h), this
        },
        _setOptions: function(a) {
            var b;
            for (b in a) this._setOption(b, a[b]);
            return this
        },
        _setOption: function(a, b) {
            return this.options[a] = b, "disabled" === a && (this.widget().toggleClass(this.widgetFullName + "-disabled ui-state-disabled", !!b).attr("aria-disabled", b), this.hoverable.removeClass("ui-state-hover"), this.focusable.removeClass("ui-state-focus")), this
        },
        enable: function() {
            return this._setOption("disabled", !1)
        },
        disable: function() {
            return this._setOption("disabled", !0)
        },
        _on: function(b, c, d) {
            var e, f = this;
            "boolean" != typeof b && (d = c, c = b, b = !1), d ? (c = e = a(c), this.bindings = this.bindings.add(c)) : (d = c, c = this.element, e = this.widget()), a.each(d, function(d, g) {
                function h() {
                    return b || f.options.disabled !== !0 && !a(this).hasClass("ui-state-disabled") ? ("string" == typeof g ? f[g] : g).apply(f, arguments) : void 0
                }
                "string" != typeof g && (h.guid = g.guid = g.guid || h.guid || a.guid++);
                var i = d.match(/^(\w+)\s*(.*)$/),
                    j = i[1] + f.eventNamespace,
                    k = i[2];
                k ? e.delegate(k, j, h) : c.bind(j, h)
            })
        },
        _off: function(a, b) {
            b = (b || "").split(" ").join(this.eventNamespace + " ") + this.eventNamespace, a.unbind(b).undelegate(b)
        },
        _delay: function(a, b) {
            function c() {
                return ("string" == typeof a ? d[a] : a).apply(d, arguments)
            }
            var d = this;
            return setTimeout(c, b || 0)
        },
        _hoverable: function(b) {
            this.hoverable = this.hoverable.add(b), this._on(b, {
                mouseenter: function(b) {
                    a(b.currentTarget).addClass("ui-state-hover")
                },
                mouseleave: function(b) {
                    a(b.currentTarget).removeClass("ui-state-hover")
                }
            })
        },
        _focusable: function(b) {
            this.focusable = this.focusable.add(b), this._on(b, {
                focusin: function(b) {
                    a(b.currentTarget).addClass("ui-state-focus")
                },
                focusout: function(b) {
                    a(b.currentTarget).removeClass("ui-state-focus")
                }
            })
        },
        _trigger: function(b, c, d) {
            var e, f, g = this.options[b];
            if (d = d || {}, c = a.Event(c), c.type = (b === this.widgetEventPrefix ? b : this.widgetEventPrefix + b).toLowerCase(), c.target = this.element[0], f = c.originalEvent)
                for (e in f) e in c || (c[e] = f[e]);
            return this.element.trigger(c, d), !(a.isFunction(g) && g.apply(this.element[0], [c].concat(d)) === !1 || c.isDefaultPrevented())
        }
    }, a.each({
        show: "fadeIn",
        hide: "fadeOut"
    }, function(b, c) {
        a.Widget.prototype["_" + b] = function(d, e, f) {
            "string" == typeof e && (e = {
                effect: e
            });
            var g, h = e ? e === !0 || "number" == typeof e ? c : e.effect || c : b;
            e = e || {}, "number" == typeof e && (e = {
                duration: e
            }), g = !a.isEmptyObject(e), e.complete = f, e.delay && d.delay(e.delay), g && a.effects && (a.effects.effect[h] || a.uiBackCompat !== !1 && a.effects[h]) ? d[b](e) : h !== b && d[h] ? d[h](e.duration, e.easing, f) : d.queue(function(c) {
                a(this)[b](), f && f.call(d[0]), c()
            })
        }
    }), a.uiBackCompat !== !1 && (a.Widget.prototype._getCreateOptions = function() {
        return a.metadata && a.metadata.get(this.element[0])[this.widgetName]
    })
}(jQuery),
function(a, b) {
    "use strict";
    b.Deltatre = b.Deltatre || {}, b.Deltatre.plugins = b.Deltatre.plugins || {};
    var c = b.Deltatre,
        d = {
            islegacy: !0,
            immediate: !1,
            timestamp: "",
            timeout: 0,
            urlcheck: "",
            urlget: "",
            timerid: 0,
            elapsed: new Date,
            callbackCheck: !1,
            callback: function(c, d) {
                b.Deltatre.core.getInstance().parse(a(c)), d.html(c)
            }
        },
        e = function(d, e) {
            var f, g, h, i, j, k, l, m = d,
                n = e,
                o = /isdebug/i.test(document.location.href);
            this.init = function() {
                m.addClass("js-uefa-live"), f = n.timeout, g(!0)
            }, this.destroy = function(a) {
                b.clearTimeout(n.timerid), a && m.empty(!0)
            }, this.stop = function() {
                b.clearTimeout(n.timerid)
            }, g = function(a) {
                j() && n.timeout > 0 && (n.urlcheck ? n.timerid = b.setTimeout(function() {
                    i()
                }, n.timeout) : e.immediate && a ? h() : n.timerid = b.setTimeout(function() {
                    h()
                }, n.timeout))
            }, i = function() {
                b.clearTimeout(n.timerid), a.ajax({
                    type: "GET",
                    cache: !1,
                    url: n.urlcheck,
                    dataType: "json",
                    error: function() {
                        c.Trace("Error json - Live stopped - ", m)
                    },
                    success: function(c) {
                        o && (k(), c.timeout = f), n.timestamp.toString() !== c.timestamp.toString() ? (a.extend(n, c), h()) : (a.extend(n, c), n.timeout > 0 && j() && (n.timerid = b.setTimeout(function() {
                            i()
                        }, n.timeout))), e.callbackCheck && a.isFunction(e.callbackCheck) && e.callbackCheck(c)
                    }
                })
            }, h = function() {
                n.urlcheck && b.clearTimeout(n.timerid), "" !== n.urlget && a.ajax({
                    type: "GET",
                    cache: !1,
                    url: n.urlget,
                    success: function(a) {
                        o && !n.urlcheck && k(), l(), e.islegacy ? e.callback(m, a) : e.callback(a, m), g(!1)
                    }
                })
            }, j = function() {
                var b = a.contains ? a.contains(document.documentElement, m[0]) : m.closest("html").length > 0;
                return b
            }, k = function() {
                var a = +new Date;
                n.elapsed = a
            }, l = function() {
                e.empty && m.find(".js-uefa-live").each(function() {
                    var b = a(this).data("uefaLive");
                    b && b.destroy(!0)
                })
            }
        };
    a.fn.uefaLive = function(b) {
        b.islegacy !== !1 && (d.callback = void 0);
        var c = a.extend(!0, {}, d, b || {});
        return this.each(function() {
            var b = new e(a(this), c);
            b.init(), a(this).data("uefaLive", b)
        })
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = function(b, d) {
        var e, f, g, h = parseInt(b.closest(d.parent).css("height"), 10) - 1,
            i = d.elheight === c ? parseInt(b.css("height"), 10) : d.elheight,
            j = d.heightStart === c ? parseInt(b.css("top"), 10) : d.heightStart;
        this.init = function() {
            b.hasClass(d.classNoOffect) || b.hover(e, f)
        }, e = function() {
            g({
                top: "0px",
                height: h + "px"
            }), a.isFunction(d.opening) && d.opening(b)
        }, f = function() {
            g({
                top: j + "px",
                height: i + "px"
            }), a.isFunction(d.closing) && d.closing(b)
        }, g = function(a) {
            b.is(":animated") && b.stop(), b.animate(a, d.speed, d.openCb)
        }
    };
    a.fn.hoverSlide = function(b) {
        function e(a) {
            return a.length > 0 ? a.height() / parseInt(a.css("lineHeight").replace("px", ""), 10) : void 0
        }

        function f(a, b) {
            if (a.length > b) {
                var c = a.substr(0, b);
                return c.substr(0, c.lastIndexOf(" ")) + "..."
            }
        }
        var g = {
            speed: 100,
            classNoOffect: "noeffect",
            parent: "div.vThumbContainer",
            comment: "div.vComment",
            title: "div.vTitle",
            openCb: c,
            closeCb: c,
            heightStart: c,
            elheight: c
        };
        return a.extend(g, b), this.each(function() {
            var b = a(this),
                c = {};
            c.title = a(g.title, b), c.comment = a(g.comment, b);
            var h = b.hasClass("hideComment");
            if (h) {
                var i = c.title,
                    j = c.comment,
                    k = e(i),
                    l = e(j);
                if ("number" == typeof l && "number" == typeof k) {
                    var m;
                    switch (k) {
                        case 1:
                            m = 135;
                            break;
                        case 2:
                            m = 110;
                            break;
                        default:
                            m = 100
                    }
                    var n = f(c.comment.text(), m);
                    c.comment.text(n)
                }
            }
            var o = new d(b, g);
            o.init()
        })
    }, a.fn.imgRollover = a.fn.hoverSlide
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.Trace,
        f = {
            url: "http://www.uefa.com/library/mobile/geo/check.html"
        };
    d.Geotargeting = function(b) {
        var g = this,
            h = a.extend(!0, {}, f, b || {}),
            i = d.Geotargeting.prototype,
            j = !1,
            k = "--",
            l = !1;
        if (i._singletonInstance) return i._singletonInstance;
        i._singletonInstance = this;
        var m, n, o;
        this.country = "--", this.isValidUrl = "N", this.whenReady = function(b) {
            a.isFunction(b) && (j ? b() : i.jobs.push(b))
        }, this.getCountry = function() {
            return k.toString().toLowerCase()
        }, this.validate = function() {
            e("d3.Geotargeting - this.validate - TO BE IMPLEMENTED ")
        }, m = function() {
            var b = a.cookie("geo.CountryCode");
            b === c || null === b ? a.ajax({
                url: h.url,
                success: function(b) {
                    b !== c && 2 === b.length ? n(b, !0) : a.ajax({
                        url: h.url.replace(".html", ".htmx"),
                        success: function(a) {
                            n(a, !0)
                        }
                    })
                }
            }) : n(b, !1)
        }, n = function(b, d) {
            var e = b;
            e !== c && 2 === e.length && "--" !== e && (g.country = k = e.toLowerCase(), g.isValidUrl = "Y", !l && d && a.cookie("geo.CountryCode", k)), o()
        }, o = function() {
            for (; i.jobs.length;) i.jobs.shift().call();
            j = !0
        }, m()
    }, d.Geotargeting.prototype.jobs = []
}(jQuery, window),
function(a, b) {
    "use strict";
    b.Deltatre = b.Deltatre || {}, b.Deltatre.plugins = b.Deltatre.plugins || {};
    var c = b.Deltatre,
        d = c.plugins,
        e = c.Trace,
        f = c.Legacy ? new c.Legacy : !1;
    a.fn.d3Plugin = function(b, f) {
        var g = b.options || {};
        return c.IS_DEBUG === !0 && "[object String]" === Object.prototype.toString.call(g) && e("Options parsing error - " + f + " - ", g, this), this.each(function() {
            var c = a(this);
            d[f] || !d.generic || d.generic.prototype.plugins[f] || e(f + " does not exist");
            try {
                var h = c.data(f);
                if (h) e("plugin yet launched", c, g, f);
                else {
                    var i;
                    d[f] ? i = new d[f](c, g) : d.generic && d.generic.prototype.plugins[f] && (i = new d.generic(f, c, g)), b.api || i.api ? c.data(f, i) : c.data(f, !0), i.init()
                }
            } catch (j) {
                e(j), e("plugin function error", c, g, f)
            }
        })
    }, c.core = function() {
        var b, g, h, i, j = this;
        this.launchPlugin = function(a) {
            var b = a.data("plugin");
            return b ? void h(a, b) : (e("can not find data-plugin for element"), void e(a))
        }, this.launchPlugins = function(d, j) {
            var k;
            j || (j = ".d3-plugin"), f && d === document && ".d3-plugin" === j && f.parse(a(d)), d = a(d), d.is(j) && (d = d.parent());
            var l, m, n = d.find(j),
                o = n.length;
            for (l = 0; o > l; l++) m = n.eq(l), k = m.data("plugin"), k ? b(k) ? h(m, k) : c.LazyScript ? g(m, k) : e("d3.LazyScript missing - plugin not exist:", m, k) : (e("can not find data-plugin for element"), e(m));
            i(d)
        }, this.parse = this.launchPlugins, this.parentPlugin = function(b, c) {
            return a(b).closest('[data-plugin="' + c + '"]').data(c)
        }, h = function(b, c) {
            var d, e;
            b.each(function(b, f) {
                d = a(f), e = d.data(), d.d3Plugin(e, c)
            })
        }, g = function(a, b) {
            var f = a.data("script") || d.jsInjectionTable && d.jsInjectionTable[b];
            if (f) {
                var g = new c.LazyScript(b, f);
                g.whenReady(function() {
                    h(a, b)
                })
            } else e("can not find plugin for element", b), e(a)
        }, b = function(a) {
            return !!d[a] || d.generic && !!d.generic.prototype.plugins[a]
        }, i = function(b) {
            a.each(j.parsers, function(a, c) {
                try {
                    c(b)
                } catch (d) {
                    return e("error launching parser", a), e(d), !0
                }
            })
        }
    }, a.extend(c.core.prototype, {
        parsers: {}
    });
    var g = new c.core;
    c.core.getInstance = function() {
        return g
    }
}(jQuery, window),
function(a, b) {
    "use strict";
    b.Deltatre = b.Deltatre || {}, b.Deltatre.plugins = b.Deltatre.plugins || {};
    "mobilesite" === a("body").attr("id");
    b.Deltatre.plugins.jsInjectionTable = {
        ovplayer: {
            js: "/CompiledAssets/js/plugins/ovplayer.min.js",
            css: "/CompiledAssets/css/ui-elements/videoplayer.min.css"
        },
        captcha: {
            js: "/CompiledAssets/js/plugins/captcha.source.js"
        },
        localtime: {
            js: "/CompiledAssets/js/plugins/tolocaltime.min.js"
        }
    }
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre,
        d = c.util;
    c.LazyScript = function(b, e) {
        var f, g, h = !1,
            i = c.LazyScript.prototype.instances[b];
        if (i ? f = i.prototype : (g = c.LazyScript.prototype.instances[b] = function() {}, f = g.prototype), f._singletonInstance) return f._singletonInstance;
        f._singletonInstance = this, f.jobs = [];
        var j, k;
        this.whenReady = function(b) {
            a.isFunction(b) && (h ? b() : f.jobs.push(b))
        }, j = function() {
            e.css && d.appendStyle(e.css, "d3.css." + b), d.appendScript(e.js || e, k, "d3.js." + b)
        }, k = function() {
            for (; f.jobs.length;) f.jobs.shift().call();
            h = !0
        }, j()
    }, c.LazyScript.prototype.instances = {}
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = a(b),
        e = b.Deltatre,
        f = e.Trace,
        g = e.core.getInstance();
    e.lazyload = 0, a.fn.lazyImage = function(b) {
        var c = this,
            d = b || {
                animate: !1
            };
        return this.each(function() {
            if (d.animate) {
                var b = a(this).css({
                        opacity: 0
                    }),
                    e = b.attr("data-src"),
                    f = new Image;
                a(f).bind("load", function() {
                    b.attr("src", e).animate({
                        opacity: 1
                    }).removeClass(c.selector.replace(".", ""))
                }), f.src = e
            } else a(this).attr("src", a(this).attr("data-src")).removeClass(c.selector.replace(".", ""))
        })
    }, a.fn.lazyload = function(b) {
        function h() {
            var b = 0;
            0 === k.length && (i.unbind(l.event + j), d.unbind(".lazyload" + j), a("body").unbind(".lazyload" + j), a(document).unbind(".lazyload" + j)), k.each(function() {
                var c = a(this);
                if (c.is(".d3-plugin-lazy") || !l.skip_invisible || c.is(":visible"))
                    if (a.abovethetop(this, l) || a.leftofbegin(this, l)) f("$.fn.lazyload - nothing to do");
                    else if (a.belowthefold(this, l) || a.rightoffold(this, l)) {
                    if (++b > l.failure_limit) return !1
                } else c.trigger("appear"), b = 0
            })
        }
        var i, j = ++e.lazyload,
            k = this,
            l = {
                threshold: 0,
                failure_limit: 0,
                event: "scroll.lazyload",
                effect: "show",
                container: window,
                data_attribute: "src",
                skip_invisible: !0,
                appear: null,
                load: null
            };
        return b && (c !== b.failurelimit && (b.failure_limit = b.failurelimit, delete b.failurelimit), c !== b.effectspeed && (b.effect_speed = b.effectspeed, delete b.effectspeed), a.extend(l, b)), i = l.container === c || l.container === window ? d : a(l.container), 0 === l.event.indexOf("scroll") && i.bind(l.event + j, function() {
            return h()
        }), this.each(function() {
            var b = this,
                c = a(b);
            b.loaded = !1, c.one("appear", function() {
                var d;
                this.loaded || ("img" === b.tagName.toLowerCase() ? (l.appear && (d = k.length, l.appear.call(b, d, l)), a("<img />").bind("load", function() {
                    c.attr("src", c.data(l.data_attribute)).animate({
                        opacity: 1
                    }, l.effect_speed), b.loaded = !0;
                    var e = a.grep(k, function(a) {
                        return !a.loaded
                    });
                    k = a(e), l.load && (d = k.length, l.load.call(b, d, l)), c.unbind(l.event + j), 0 == a("img.js-lazy").filter(function() {
                        return a(this).attr("src") !== a(this).attr("data-src")
                    }).size() && a(document).trigger("allimagesloaded")
                }).attr("src", c.data(l.data_attribute))) : "iframe" === b.tagName.toLowerCase() ? (b.loaded = !0, c.attr("src", c.data(l.data_attribute))) : (g.launchPlugin(c), k = k.not(c), c.unbind(l.event + j)))
            }), 0 !== l.event.indexOf("scroll") && c.bind(l.event, function() {
                b.loaded || c.trigger("appear")
            })
        }), d.bind("resize.lazyload" + j, function() {
            h()
        }), a(document).bind("ready.lazyload" + j, function() {
            h()
        }), a(document).bind("ready.lazyload" + j, function() {
            a("body").bind("click.lazyload" + j, function() {
                h()
            })
        }), a(document).bind("ajaxStop.lazyload" + j, function() {
            h()
        }), this
    }, a.belowthefold = function(b, e) {
        var f;
        return f = e.container === c || e.container === window ? d.height() + d.scrollTop() : a(e.container).offset().top + a(e.container).height(), f <= a(b).offset().top - e.threshold
    }, a.rightoffold = function(b, e) {
        var f;
        return f = e.container === c || e.container === window ? d.width() + d.scrollLeft() : a(e.container).offset().left + a(e.container).width(), f <= a(b).offset().left - e.threshold
    }, a.abovethetop = function(b, e) {
        var f;
        return f = e.container === c || e.container === window ? d.scrollTop() : a(e.container).offset().top, f >= a(b).offset().top + e.threshold + a(b).height()
    }, a.leftofbegin = function(b, e) {
        var f;
        return f = e.container === c || e.container === window ? d.scrollLeft() : a(e.container).offset().left, f >= a(b).offset().left + e.threshold + a(b).width()
    }, a.inviewport = function(b, c) {
        return !(a.rightoffold(b, c) || a.leftofbegin(b, c) || a.belowthefold(b, c) || a.abovethetop(b, c))
    }, a.extend(a.expr[":"], {
        "below-the-fold": function(b) {
            return a.belowthefold(b, {
                threshold: 0
            })
        },
        "above-the-top": function(b) {
            return !a.belowthefold(b, {
                threshold: 0
            })
        },
        "right-of-screen": function(b) {
            return a.rightoffold(b, {
                threshold: 0
            })
        },
        "left-of-screen": function(b) {
            return !a.rightoffold(b, {
                threshold: 0
            })
        },
        "in-viewport": function(b) {
            return a.inviewport(b, {
                threshold: 0
            })
        },
        "above-the-fold": function(b) {
            return !a.belowthefold(b, {
                threshold: 0
            })
        },
        "right-of-fold": function(b) {
            return a.rightoffold(b, {
                threshold: 0
            })
        },
        "left-of-fold": function(b) {
            return !a.rightoffold(b, {
                threshold: 0
            })
        }
    })
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre,
        d = (c.plugins, c.Trace),
        e = c.core.getInstance();
    a(document).ready(function() {
        try {
            var a = document;
            e.launchPlugins(a, ".d3-plugin")
        } catch (b) {
            d(b), d("core function error")
        }
    })
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre,
        d = c.Trace,
        e = {
            parsers: {
                lazyload: {
                    selector: "img.js-lazy,iframe.js-lazy, .d3-plugin-lazy",
                    options: {}
                },
                hoverSlide: {
                    selector: ".js-hoverslide"
                }
            }
        };
    c.core.prototype.parsers.generic = function(b) {
        a.each(e.parsers, function(c, e) {
            a.fn[c] ? a(e.selector, b)[c](e.options) : d("generic parser : jquery plugin not defined.", c)
        })
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins;
    d.Trace;
    e.search = function(b, c) {
        var d = b,
            e = {};
        this.init = function() {
            e.input = d.find(".js-input"), e.seVal = d.find(".js-label"), d.submit(function(a) {
                var b = e.input.val();
                b.toLowerCase() !== e.seVal.text() && "" !== b && (location.href = "http://" + SEARCH_HOSTNAME + "/search/index.html#" + b), a.preventDefault()
            }), e.input.focus(function() {
                a(this).val().toLowerCase() === e.seVal.text().toLowerCase() && a(this).val("")
            })
        }
    }, "/search/index.html" === location.pathname && location.search.length > 0 && (location.href = location.href + "#" + location.search.replace("?q=", ""))
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre,
        d = c.plugins,
        e = {
            timeout: 6e4,
            isthirdy: "Y",
            url: "/livecommon/_matchesminute_jsonp.json",
            domain: "http://www.uefa.com"
        };
    d.jsonplive = function(d, f) {
        var g, h, i = this,
            j = a.extend(!0, {}, e, f || {}),
            k = d,
            l = [1, 3, 5, 9, 13, 14, 17, 18, 22, 23, 24, 25, 27, 28, 38, 39, 101, 2008, 1026, 1027, 1028, 1031, 1032, 1035, 1038, 1039, 1042, 1046, 1048, 1049, 1050, 1053, 1054, 1055, 1056, 1062, 1069];
        this.init = function() {
            c.Uefacom = c.Uefacom || {}, c.Uefacom.Livepolling = c.Uefacom.Livepolling || {}, c.Uefacom.Livepolling.checklive = i.checklive, "Y" === j.isthirdy && (j.url = j.domain + j.url), h()
        }, this.checklive = function(b) {
            g = !1, a.each(b.m, function(b, c) {
                return a.inArray(c.cup, l) > -1 && "3" === c.s ? (g = !0, !1) : void 0
            }), k.toggleClass("is-live", g), window.Deltatre.plugins.jsonplive.prototype.data = b, a(document).trigger("jsonplive.ondata")
        }, h = function() {
            a.ajax({
                type: "GET",
                url: j.url,
                dataType: "jsonp"
            }), b.setTimeout(h, j.timeout)
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = d.core.getInstance(),
        g = {
            handler: !1,
            event: "event",
            plugin: !1,
            via: "lazybyevent"
        };
    e.lazybyevent = function(b, d) {
        var e, h = a.extend(!0, {}, g, d || {}),
            i = b,
            j = {};
        this.init = function() {
            j.handler = h.handler ? i.find(h.handler) : i, "hoverIntent" === h.event && a.fn.hoverIntent === c && (h.event = "mouseenter"), a("html").hasClass("d3cmsMobile") && (h.event = "touchend"), "hoverIntent" === h.event ? j.handler.hoverIntent({
                over: function() {
                    e()
                },
                interval: 250
            }) : j.handler.one(h.event, function() {
                e()
            })
        }, e = function() {
            i.data("options", h).data("plugin", h.plugin), a.metadata && (i.metadata("data-options", h), i.attr("data-plugin", h.plugin)), f.parse(i)
        }
    }
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre,
        d = c.plugins;
    d.generic = function(a, b, c) {
        var d = b;
        this.init = function() {
            return d[this.plugins[a]](c)
        }
    }, d.generic.prototype.plugins = {
        facebook: "d3fb",
        twitter: "d3twitter",
        "js-fblazy": "fblazy"
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1,
            language: "en"
        });
    e.langselection = function(b, c) {
        var d, e = (a.extend(!0, {}, f, c || {}), b),
            g = {};
        this.init = function() {
            g.buttons = e.find(".langSelection"), g.buttons.click(function(b) {
                b.preventDefault(), d(a(this))
            })
        }, d = function(b) {
            a.cookie("esiForcedLanguage", b.attr("langID"), {
                expires: 365,
                domain: ".uefa.com",
                path: "/"
            }), document.location.href = b.attr("href")
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1
        });
    e.stdlogin = function(b, c) {
        var d, e, g, h, i = (a.extend(!0, {}, f, c || {}), b),
            j = {},
            k = "http://" + getUrlLang(window.location.href) + currentDomain,
            l = getReturnUrl(window.location.href);
        this.init = function() {
            j.form = i.find(".js-std-login-form"), j.email = j.form.find(".js-std-login-input.email"), j.pwd = j.form.find(".js-std-login-input.password"), j.keeplogin = j.form.find(".js-std-login-keeplogin"), d(), j.form.find(".js-std-login-social-link").each(function() {
                var b = a(this);
                b.attr("href", k + "/Account/LoginWith" + b.data("service") + "?returnUrl=" + l)
            }), j.form.find(".js-std-login-forgot").attr("href", k + "/ForgottenPassword"), j.form.find(".js-std-login-register").attr("href", k + "/Account/SignUp?returnUrl=" + l), j.form.on("submit", function(a) {
                return a.preventDefault(), e(), !1
            }), j.email.on("focus change", function() {
                a(this).parent().removeClass("js-error")
            }), j.pwd.on("focus change", function() {
                a(this).parent().removeClass("js-error")
            })
        }, d = function() {
            "undefined" == typeof myHeader && (myHeader = new headerScript)
        }, e = function() {
            g([{
                field: j.email,
                type: "requiredEmail"
            }, {
                field: j.pwd,
                type: "required"
            }]) && doLogin(j.email.val().replace(/\s/g, ""), j.pwd.val().replace(/\s/g, ""), j.keeplogin.prop("checked"), l)
        }, g = function(a) {
            for (var b = !0, c = 0; c < a.length; c++) switch (a[c].type) {
                case "required":
                    "" !== a[c].field.val() ? a[c].field.parents(".js-std-login-field").removeClass("js-error") : (a[c].field.parents(".js-std-login-field").addClass("js-error"), b = !1);
                    break;
                case "requiredEmail":
                    var d = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
                    d.test(a[c].field.val().replace(/\s/g, "")) === !1 ? (a[c].field.parents(".js-std-login-field").addClass("js-error"), b = !1) : a[c].field.parents(".js-std-login-field").removeClass("js-error");
                    break;
                default:
                    console.log("No type matched")
            }
            return b
        }, h = function() {
            j.form.find(".js-error").removeClass("js-error"), j.email.val(""), j.pwd.val("")
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = d.core.getInstance(),
        g = {
            yesLink: null,
            noLink: null,
            noLinkOverride: null,
            compName: null,
            countriesAllow: null
        };
    e.geoTargetingIncluder = function(e, h) {
        var i, j, k = a.extend(!0, {}, g, h || {}),
            l = e;
        this.init = function() {
            i = new d.Geotargeting(k), i.whenReady(j)
        }, j = function() {
            var d, e = !0,
                g = "{country}";
            k.noLinkOverride ? d = k.noLinkOverride.replace(g, "IT") : k.noLink && (d = k.noLink), "Y" === i.isValidUrl && k.yesLink && (k.countriesAllow && (k.countriesAllow = k.countriesAllow.toLowerCase().split(",")), e = !k.countriesAllow || k.countriesAllow && a.inArray(i.getCountry(), k.countriesAllow) >= 0, e && (d = k.yesLink.replace(g, i.getCountry()))), d.length > 0 && d !== b.location.pathname && (d = (b.CMSPath || "") + d, a.get(d, function(b) {
                var d = a(b);
                k.methodToCall !== c && "" !== k.methodToCall && "function" == typeof window[k.methodToCall] && (d = window[k.methodToCall](d)), l.find(".js-target").html(d), f.parse(d)
            }))
        }
    }
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre,
        d = c.plugins,
        e = {
            randomize: !0,
            geotargeting: !0,
            trackatstart: !1,
            items: [],
            extract: 2,
            force: void 0,
            weighted: void 0,
            datasponsor: void 0,
            datascope: void 0,
            datatrack: void 0,
            views: {
                random_list: '<div class="random_list clearfix" />',
                survey_list: '<div class="random_list clearfix container" />'
            }
        };
    d.sponsorsrandom = function(d, f) {
        var g, h, i, j, k, l, m, n, o, p = a.extend(!0, {}, e, f || {}),
            q = d,
            r = {},
            s = [];
        this.init = function() {
            r.target = q.find(".js-target"), r.target.length || (r.target = q), p.geotargeting ? (g = new c.Geotargeting(p), g.whenReady(h)) : h()
        }, h = function() {
            p.randomize ? i() : p.geotargeting ? j() : k(), l(), p.trackatstart && n()
        }, j = function() {
            var b = g.getCountry();
            a.each(p.items, function(a, c) {
                return s.length >= p.extract ? !1 : void(c.nocountry ? -1 === c.nocountry.toUpperCase().split(",").indexOf(b.toUpperCase()) && s.push(c) : s.push(c))
            })
        }, k = function() {
            s = p.items.slice(0, p.extract)
        }, n = function() {
            var c = !1,
                d = [];
            a.each(s, function(a, b) {
                "Y" === b.track ? (d.push(b.title.toLowerCase()), c = !0) : c = !1
            }), c && b.SCW.TL(this, "o", "Tool Used", {
                linkTrackVars: "events,eVar43",
                linkTrackEvents: "event20",
                events: "event20",
                eVar43: "top sponsors views - " + d.join(" | ")
            })
        }, i = function() {
            for (var a, b, c = 0, d = p.items.length, e = p.extract, f = g ? g.getCountry() : !1; e > 0 && !(c >= d);) a = void 0 !== p.force && p.force.length > 0 ? p.force.pop() : void 0 !== p.weighted && "y" === p.weighted.toLowerCase() ? o() : Math.floor(Math.random() * p.items.length), b = p.items.splice(p.items.indexOf(p.items[a]), 1).pop(), f ? b.nocountry && b.nocountry.toUpperCase().split(",").indexOf(f.toUpperCase()) > -1 || (s.push(b), e--) : (s.push(b), e--), c++
        }, o = function() {
            var b, c = [],
                d = 0;
            a.each(p.items, function(a, b) {
                d += b.weight, c.push(d)
            });
            var e = Math.floor(100 * Math.random()) + 1;
            return b = 0, a.each(c, function(a, c) {
                return b = a, c > e ? !1 : void 0
            }), b
        }, l = function() {
            var b, c, d, e, f;
            f = a("<ul />"), p.views[p.view] ? (e = a(p.views[p.view]), f.appendTo(e)) : e = f, a.each(s, function(a, e) {
                b = e.url.split("|"), c = e.title.split("|"), d = m(e, b, c), f.append(d)
            }), r.target.append(e)
        }, m = function(b, c, d) {
            var e = [],
                f = "sponsor-item-link " + (c.length > 1 ? "half-link" : "single-link");
            a.each(c, function(c, g) {
                e.push(a("<a>").attr({
                    Class: f,
                    title: d[c] || "",
                    href: g || "#",
                    target: "_blank",
                    "data-track": b.track || ""
                }).click(function(a) {
                    g && window.open(g, "_blank"), b.track && "y" === b.track.toLowerCase() && SCW.TL(this, "o", "Tool Used", {
                        linkTrackVars: "events,eVar43",
                        linkTrackEvents: " event20",
                        events: "event20",
                        eVar43: "top sponsors click - " + d[c].toLowerCase()
                    }), a.preventDefault()
                }))
            });
            var g = b.src;
            b.retina && (g += " 1x, " + b.retina + " 2x");
            var h = a("<img>").addClass("sponsor-item-img").attr({
                    srcset: g,
                    title: b.title || ""
                }),
                i = a("<div>").addClass("sponsor-item-wrap").css({
                    width: b.width,
                    height: b.height
                }).append(h).append(e);
            return a("<li>").addClass("sponsor-item").attr({
                "data-sponsor": b.datasponsor || "",
                "data-scope": b.datascope || "",
                "data-track": b.datatrack || ""
            }).append(i)
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = {
            targetDate: {
                sec: c,
                min: c,
                hour: c,
                day: c,
                month: c,
                year: c
            },
            dateFormat: "",
            min: "",
            max: ""
        },
        g = new d.Cache;
    e.timeago = function(b, c) {
        var d, h, i, j = a.extend(!0, {}, f, c || {}),
            k = b,
            l = this,
            m = {},
            n = {},
            o = 'WARNING! You have to call first the "loadDateTranslation" method and then do the work in his callback',
            p = {
                s: 59,
                ss: 119,
                m: 59,
                mm: 119,
                h: 23,
                hh: 47,
                d: 29,
                dd: 59,
                dy: 364,
                dyy: 729
            };
        l.init = function() {
            n.now = new Date, n.cetOffset = 36e5 * (n.now.dst() ? 2 : 1), n.gmtOffset = -(60 * n.now.getTimezoneOffset() * 1e3) - n.cetOffset, n.targetDate = new Date(j.targetDate.year, j.targetDate.month - 1, j.targetDate.day, j.targetDate.hour, j.targetDate.min, j.targetDate.sec, 0), n.dateLocal = new Date(Math.floor(n.targetDate.getTime() + n.gmtOffset)), h(), m.setTimeAgo()
        }, m.setTimeAgo = function() {
            n.tolocal = new e.tolocaltime(k, j), n.tolocal.loadDateTranslation().then(function() {
                n.dateObj = {
                    d: n.dateLocal.getDate(),
                    D: 0 === n.dateLocal.getDay() ? 7 : n.dateLocal.getDay(),
                    M: n.dateLocal.getMonth() + 1,
                    y: n.dateLocal.getFullYear(),
                    H: n.dateLocal.getHours(),
                    m: n.dateLocal.getMinutes(),
                    s: n.dateLocal.getSeconds(),
                    L: n.dateLocal.getMilliseconds(),
                    o: n.now.getTimezoneOffset()
                };
                var b = d();
                a.when(b).done(function(a) {
                    k.text(a)
                })
            })
        }, d = function() {
            return n.days > j.max ? n.tolocal.getDateString(!0, j.dateFormat, n.dateObj).then(function(a) {
                return a
            }) : n.days > p.dy ? n.days > p.dyy ? i("years").replace("{0}", n.years) : i("year") : n.days > p.d ? n.days > p.dd ? i("months").replace("{0}", n.months) : i("month") : n.hours > p.h ? n.hours > p.hh ? i("days").replace("{0}", n.days) : i("day") : n.seconds > j.min && n.minutes > p.m ? n.minutes > p.mm ? i("hours").replace("{0}", n.hours) : i("hour") : n.seconds > j.min && n.seconds > p.s ? n.seconds > p.ss ? i("minutes").replace("{0}", n.minutes) : i("minute") : i("time_now")
        }, h = function() {
            var a = Math.abs(Math.floor(n.now.getTime() - n.dateLocal.getTime()));
            n.years = Math.abs(n.now.getFullYear() - n.targetDate.getFullYear()), n.months = Math.abs(n.now.getMonth() - n.targetDate.getMonth() + 12 * (n.now.getFullYear() - n.targetDate.getFullYear())), n.days = Math.floor(a / 864e5), n.hours = Math.floor(a / 36e5), n.minutes = Math.floor(a / 6e4), n.seconds = Math.floor(a / 1e3)
        }, i = function(a) {
            var b = "timeago",
                c = g.get("/libraries/_datetranslation");
            if (!c) throw o;
            return c[b] && c[b][a] ? c[b][a] : a
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            url: null,
            text: null,
            version: 1,
            language: "en"
        });
    e.social = function(b, c) {
        var d = this,
            e = a.extend(!0, {}, f, c || {}),
            g = b;
        d.init = function() {
            var b = a("html").attr("lang") || e.language,
                c = e.url || location.href || "",
                d = e.text || document.title || "",
                f = e.via || "",
                h = e.hashtags || "";
            a(".js-share-twitter", g).on("click", function(a) {
                a.preventDefault()
            }).tweetbook("tweet", c, d, f, h, b, 600, 350), a(".js-share-facebook", g).on("click", function(a) {
                a.preventDefault()
            }).tweetbook("fb_dialog", c, d, h, 660, 500)
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = {
            targetDate: {
                sec: c,
                min: c,
                hour: c,
                day: c,
                month: c,
                monthS: c,
                year: c
            },
            vocabularyTags: {
                countdown: c,
                datetime: c
            },
            live: !0
        };
    e.countdown = function(c, d) {
        var e, g = a.extend(!0, {}, f, d || {}),
            h = c,
            i = {},
            j = {},
            k = {},
            l = !1;
        this.init = function() {
            if (h.addClass("ui-countdown"), k.now = new Date, k.cetOffset = 36e5 * (k.now.dst() ? 2 : 1), k.gmtOffset = -(60 * k.now.getTimezoneOffset() * 1e3) - k.cetOffset, k.targetDate = new Date(g.targetDate.year, g.targetDate.month - 1, g.targetDate.day, g.targetDate.hour, g.targetDate.min, g.targetDate.sec, 0), g.vocabularyTags.countdown) {
                var a = g.vocabularyTags.countdown.replace("@s@", '<span id="ui-countdown-sec" ></span>').replace("@m@", '<span id="ui-countdown-min" ></span>').replace("@h@", '<span id="ui-countdown-hours" ></span>').replace("@d@", '<span id="ui-countdown-days" ></span>');
                h.find(".ui-countdown").html(a), i.secondsLabel = h.find(".ui-countdown #ui-countdown-sec"), i.minutesLabel = h.find(".ui-countdown #ui-countdown-min"), i.hoursLabel = h.find(".ui-countdown #ui-countdown-hours"), i.daysLabel = h.find(".ui-countdown #ui-countdown-days"), j.dateDiff(), j.setTime(4), g.live && !l && (e = b.setInterval(function() {
                    j.move()
                }, 1e3))
            }
            j.setDateLocal()
        }, j.is_live = function() {
            var a = !1;
            return (k.seconds > 0 || k.minutes > 0 || k.hours > 0 || k.days > 0) && (a = !0), a || (b.clearInterval(e), l = !0, e = null), a
        }, j.setTime = function(a) {
            return j.is_live() ? void(a > 0 && (a > 3 && i.daysLabel.text(k.days), a > 2 && i.hoursLabel.text(k.hours), a > 1 && i.minutesLabel.text(k.minutes), i.secondsLabel.text(k.seconds), j.setTime(a - 1))) : !1
        }, j.move = function() {
            j.is_live() && (k.seconds -= 1, j.setTime(1), k.seconds < 0 && (k.seconds = 59, k.minutes -= 1, j.setTime(2), k.minutes < 0 && (k.minutes = 59, k.hours -= 1, j.setTime(3), k.hours < 0 && (k.hours = 23, k.days -= 1, j.setTime(4)))))
        }, j.dateDiff = function() {
            var a, b = Math.floor(k.targetDate.getTime() - k.now.getTime() + k.gmtOffset);
            k.digits = [], a = 0 >= b ? 0 : Math.floor(b / 864e5), k.days = a, b -= 864e5 * a, a = 0 >= b ? 0 : Math.floor(b / 36e5), k.hours = a, b -= 36e5 * a, a = 0 >= b ? 0 : Math.floor(b / 6e4), k.minutes = a, b -= 6e4 * a, a = 0 >= b ? 0 : Math.floor(b / 1e3), k.seconds = a, b -= 1e3 * a, 0 >= b && (l = !0)
        }, j.setDateLocal = function() {
            if (g.vocabularyTags.datetime) {
                var a = new Date(Math.floor(k.targetDate.getTime() + k.gmtOffset)),
                    b = a.getMinutes().toString(),
                    c = a.getHours().toString(),
                    d = a.getDate().toString(),
                    e = (a.getFullYear().toString(), g.vocabularyTags.datetime.replace("@m@", j.padLeft(b, 2)).replace("@h@", j.padLeft(c, 2)).replace("@d@", d).replace("@mt@", g.targetDate.monthS).replace("@y@", g.targetDate.year));
                h.find(".ui-datetime").text(e)
            }
        }, j.padLeft = function(a, b) {
            var c, d = [],
                e = "",
                f = a.toString().split(""),
                g = b - f.length;
            if (b > f.length)
                for (c = 0; g > c; c++) d.push(0);
            for (c = 0; c < f.length; c++) d.push(parseInt(f[c], 10));
            for (c = 0; c < d.length; c++) e = e.concat(d[c]);
            return e
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1,
            language: "en"
        });
    e.favouritefollow = function(c, e) {
        var g, h, i, j, k = this,
            l = a.extend(!0, {}, f, e || {}),
            m = c,
            n = {},
            o = null,
            p = null,
            q = null,
            r = null;
        k.init = function() {
            if (g = new User, p = m.data("team"), r = m.data("player"), p && !o && d.favouriteTeam) o = new d.favouriteTeam, o.getFavouriteTeamId().then(function(a) {
                null === a && g.isLogged() && (g.loadData(), q = g.Data.FavTeamsNames, q > 0 && n.teamItems.filter("[data-team=" + q + "]").length > 0 && (a = q)), h(a > 0 && a == p)
            });
            else if (r && !o && d.favouritePlayer && l.url) {
                var b = l.url;
                o = new d.favouritePlayer(b)
            }
            if (n.follow_lbl = m.find(".js-follow"), n.following_lbl = m.find(".js-following"), r) {
                var c = a.parseJSON(o.getFavouritePlayerIds());
                h(null !== c && null !== c.followed && c.followed.indexOf(r) > -1)
            }
            m.on("click", function(a) {
                a.preventDefault(), m.hasClass("following") === !1 ? i(p || r) : j(p || r)
            })
        }, i = function(c) {
            p && o.setFavouriteTeam(c), r && o.setFavouritePlayer(c), h(!0), o.setFavouriteClass(c), a(b).trigger("changefavourite")
        }, j = function(c) {
            r && (o.unsetFavouritePlayer(c), h(!1), o.unsetFavouriteClass(c), a(b).trigger("changefavourite"))
        }, h = function(a) {
            m.toggleClass("following", a), n.following_lbl.toggleClass("hide", !a), n.follow_lbl.toggleClass("hide", a)
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1,
            language: "en"
        });
    e.favouriteselection = function(c, e) {
        var g, h, i, j, k, l, m, n, o, p, q, r, s = this,
            t = (a.extend(!0, {}, f, e || {}), c),
            u = {},
            v = null,
            w = null,
            x = null,
            y = "preferredTeamPref";
        s.init = function() {
            g = new User, !v && d.favouriteTeam && (v = new d.favouriteTeam), u.dropdown = t, u.teams = t.find(".js-favteam"), u.favteamlink = t.find(".js-favteam-link"), u.favteampage = u.favteamlink.find(".js-favteam-page"), u.favteamtickets = u.favteamlink.find(".js-favteam-tickets"), u.teamItems = t.find(".js-favteam-item"), u.button = t.find(".js-favteam-btn"), u.clear = t.find(".js-favteam-clear"), u.keep = t.find(".js-favkeep"), u.keepTeam = u.keep.find(".js-favkeep-team"), u.btnKeepYes = u.keep.find(".js-favkeep-yes-btn"), u.btnKeepNo = u.keep.find(".js-favkeep-no-btn"), u.btnKeepBack = u.keep.find(".js-favkeep-back-btn"), u.mps = t.find(".js-favmps"), u.mpsText = u.mps.find(".js-favmps-mps-txt"), u.mpsText2 = u.mps.find(".js-favmps-mps-txt2"), u.btnMpsYes = u.mps.find(".js-favmps-yes-btn"), u.btnMpsNo = u.mps.find(".js-favmps-no-btn"), u.login = t.find(".js-favlogin"), u.loginTeam = u.login.find(".js-favlogin-team"), u.btnLoginBack = u.login.find(".js-favlogin-back-btn"), v.getFavouriteTeamId().then(function(a) {
                null === a && g.isLogged() && (g.loadData(), x = g.Data.FavTeamsNames, x > 0 && u.teamItems.filter("[data-team=" + x + "]").length > 0 && (a = x)), h("teams"), a > 0 && n(a)
            }), u.teamItems.off("click").on("click", function(b) {
                b.preventDefault();
                var c = a(this),
                    d = c.data("team");
                n(d), q()
            }), u.clear.off("click").on("click", function(a) {
                a.preventDefault(), n(0), q()
            }), u.dropdown.on("hidden.bs.dropdown", function() {
                h("teams")
            })
        }, l = function(b) {
            var c = {};
            return c = "undefined" != typeof Storage ? a.parseJSON(localStorage[y] || "{}") : a.parseJSON(a.cookie(y) || "{}"), c[b] === !0
        }, m = function(b, c) {
            var d = {};
            if (d = "undefined" != typeof Storage ? a.parseJSON(localStorage[y] || "{}") : a.parseJSON(a.cookie(y) || "{}"), d[b] = c, "undefined" != typeof Storage) localStorage[y] = JSON.stringify(d);
            else {
                var e = document.domain.indexOf("uefa.com") > -1 ? "uefa.com" : document.domain.indexOf("deltatre.it") > -1 ? "deltatre.it" : "";
                a.cookie(y, JSON.stringify(d), {
                    expires: 365,
                    path: "/",
                    domain: e
                })
            }
        }, n = function(c) {
            v.setFavouriteTeam(c), c > 0 ? o(c) : p(), v.setFavouriteClass(c), a(b).trigger("changefavourite")
        }, h = function(a) {
            switch (u.teams.addClass("hidden"), u.keep.addClass("hidden"), u.mps.addClass("hidden"), u.login.addClass("hidden"), a) {
                case "keep":
                    u.keep.removeClass("hidden");
                    break;
                case "mps":
                    u.mps.removeClass("hidden");
                    break;
                case "login":
                    u.login.removeClass("hidden");
                    break;
                default:
                    u.teams.removeClass("hidden")
            }
        }, i = function(a) {
            r("keep");
            var b = u.teamItems.filter("[data-team=" + a + "]");
            u.keepTeam.html(b.html()), u.btnKeepYes.off("click").on("click", function(b) {
                b.preventDefault(), j(a)
            }), u.btnKeepNo.off("click").on("click", function(b) {
                b.preventDefault(), n(a), q()
            }), u.btnKeepBack.off("click").on("click", function(a) {
                a.preventDefault(), r("teams")
            })
        }, j = function(a) {
            r("login");
            var b = u.teamItems.filter("[data-team=" + a + "]");
            u.loginTeam.html(b.html()), u.btnLoginBack.off("click").on("click", function(b) {
                b.preventDefault(), i(a)
            }), n(a), m("forceMPScheck", !0)
        }, k = function(a) {
            v.getTeamNameFromId(x).then(function(b) {
                v.getTeamNameFromId(a).then(function(c) {
                    u.mpsText.text(u.mpsText.data("text").replace("{0}", b)), u.mpsText2.text(u.mpsText2.data("text").replace("{0}", c)), r("mps"), u.btnMpsYes.off("click").on("click", function(b) {
                        b.preventDefault(), v.updateMPS(a), m("updateMPScheck", !0), m("forceMPScheck", !1), q()
                    }), u.btnMpsNo.off("click").on("click", function(a) {
                        a.preventDefault(), m("updateMPScheck", !0), m("forceMPScheck", !1), q()
                    })
                })
            })
        }, o = function(a) {
            w = a;
            var b = u.teamItems.filter("[data-team=" + a + "]"),
                c = u.favteampage.data("href").replace("TEAMID", a);
            u.favteampage.html(b.html()).attr("href", c), c = u.favteamtickets.data("href").replace("TEAMID", a), u.favteamtickets.attr("href", c), u.clear.removeClass("hidden"), u.favteamlink.removeClass("hidden"), u.button.text(u.button.data("change-txt")), u.button.addClass("fav-selected")
        }, p = function() {
            w = null, h("teams"), u.clear.addClass("hidden"), u.favteampage.html(""), u.favteamlink.addClass("hidden"), u.button.text(u.button.data("select-txt")), u.button.removeClass("fav-selected")
        }, q = function() {
            h("teams"), u.dropdown.hasClass("open") && u.button.dropdown("toggle")
        }, r = function(a) {
            h(a), u.dropdown.hasClass("open") === !1 && u.button.dropdown("toggle")
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1
        });
    e.loginpanel = function(b, c) {
        var d, e, g, h, i = (a.extend(!0, {}, f, c || {}), b),
            j = {},
            k = "http://" + getUrlLang(window.location.href) + currentDomain,
            l = getReturnUrl(window.location.href);
        this.init = function() {
            j.form = i.find('[data-js="login-form"]'), j.email = a("#uefa-login-email"), j.pwd = a("#uefa-login-password"), j.keeplogin = a("#uefa-login-keep"), d(), j.form.find('[data-js="login-social"]').each(function() {
                var b = a(this);
                b.attr("href", k + "/Account/LoginWith" + b.data("service") + "?returnUrl=" + l)
            }), a("#uefa-login-forgot").attr("href", k + "/ForgottenPassword"), a("#uefa-login-register").attr("href", k + "/Account/SignUp?returnUrl=" + l), j.form.on("submit", function(a) {
                return a.preventDefault(), e(), !1
            }), j.email.on("focus change", function() {
                a(this).parent().removeClass("error")
            }), j.pwd.on("focus change", function() {
                a(this).parent().removeClass("error")
            })
        }, d = function() {
            "undefined" == typeof myHeader && (myHeader = new headerScript)
        }, e = function() {
            g([{
                field: j.email,
                type: "requiredEmail"
            }, {
                field: j.pwd,
                type: "required"
            }]) && doLogin(j.email.val().replace(/\s/g, ""), j.pwd.val().replace(/\s/g, ""), j.keeplogin.prop("checked"), l)
        }, g = function(a) {
            for (var b = !0, c = 0; c < a.length; c++) switch (a[c].type) {
                case "required":
                    "" !== a[c].field.val() ? a[c].field.parents('[data-js="login-input"]').removeClass("has-error") : (a[c].field.parents('[data-js="login-input"]').addClass("has-error"), b = !1);
                    break;
                case "requiredEmail":
                    var d = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
                    d.test(a[c].field.val().replace(/\s/g, "")) === !1 ? (a[c].field.parents('[data-js="login-input"]').addClass("has-error"), b = !1) : a[c].field.parents('[data-js="login-input"]').removeClass("has-error");
                    break;
                default:
                    console.log("No type matched")
            }
            return b
        }, h = function() {
            j.form.find(".has-error").removeClass("has-error"), j.email.val(""), j.pwd.val("")
        }
    }
}(jQuery, window),
function(a) {
    function b() {
        var a;
        window.document.createEvent ? (a = document.createEvent("HTMLEvents"), a.initEvent("resize", !0, !0)) : (a = document.createEventObject(), a.eventType = "resize"), a.eventName = "resize", document.createEvent ? window.dispatchEvent(a) : window.fireEvent("on" + a.eventType, a)
    }

    function c() {
        var b = f.scrollTop(),
            c = b + f.height(),
            d = b - g,
            e = c + g;
        i = h.not(":hidden").filter(function() {
            var b = a(this),
                c = b.offset().top,
                f = c + b.height();
            return f >= d && e >= c
        }), j = i.trigger("pflazyload"), h = h.not(j)
    }

    function d(a, b, c) {
        b = b || 250;
        var d, e;
        return function() {
            var f = c || this,
                g = +new Date,
                h = arguments;
            d && d + b > g ? (clearTimeout(e), e = setTimeout(function() {
                d = g, a.apply(f, h)
            }, b)) : (d = g, a.apply(f, h))
        }
    }

    function e(a, c) {
        var d = a.getAttribute("data-srcset"),
            e = a.getAttribute("data-sizes");
        d && (a.removeAttribute("src"), a.removeAttribute("data-srcset"), a.removeAttribute("data-sizes"), a.setAttribute("srcset", d), a.setAttribute("sizes", e), c && (window.picturefill({
            reevaluate: !0,
            elements: [a]
        }), "function" == typeof callback && callback.call(a))), b()
    }
    var f, g, h, i, j, k;
    a.fn.pflazyload = function(b, i) {
        return f = a(window), g = b || 0, void 0 !== this && (void 0 === h || 0 === h.length ? h = this : a.each(this, function(b, c) {
            a.inArray(this, h) < 0 && h.push(this)
        })), h.one("pflazyload", function() {
            var b = this;
            if (a(b).hasClass("picture")) {
                var c = a(b).parents("picture").find("source");
                a.each(c, function() {
                    e(this)
                }).promise().done(function() {
                    e(b, !0)
                })
            } else e(b, !0)
        }).on("load", function() {
            var b = a(this).data("fallback");
            if (a(this).removeClass("lazyfade"), this.naturalWidth <= 1 && b && b.length > 0) {
                var c = this.currentSrc;
                if (a(this).hasClass("picture")) {
                    var d = a(this).parents("picture").find("source");
                    a.each(d, function() {
                        var a = this.getAttribute("srcset").replace(new RegExp(c, "g"), b);
                        this.setAttribute("srcset", a)
                    })
                } else {
                    var e = this.getAttribute("srcset").replace(new RegExp(c, "g"), b);
                    this.setAttribute("srcset", e)
                }
                a(this).addClass("lazyfallback"), window.picturefill({
                    reevaluate: !0,
                    elements: [this]
                }), "function" == typeof i && i.call(this)
            } else this.currentSrc.indexOf(b) > 0 && a(this).removeClass("lazyfallback")
        }), k = d(c, 500), f.off("scroll.pflazyload", k).on("scroll.pflazyload", k), f.off("resize.pflazyload", k).on("resize.pflazyload", k), f.off("move.carousel", c).on("move.carousel", c), c(), this
    }, a(document).ready(function() {
        a(".pflazyload").pflazyload(300), a(window).on("load", function() {
            a(window).trigger("scroll.pflazyload"), a(window).trigger("resize.pflazyload")
        })
    })
}(window.jQuery),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1,
            handlersDelay: 100,
            stickyThreshold: 100
        });
    e.responsivemenu = function(c, d) {
        var e, g, h, i, j, k = this,
            l = a.extend(!0, {}, f, d || {}),
            m = c,
            n = {},
            o = a(b),
            p = 0;
        return this.init = function() {
            n.nav = m.find(".nav"), n.topItems = n.nav.find(">li").not(".moremenu"), n.moreBtn = m.find(".moremenu"), n.moreMenu = n.moreBtn.find(".dropdown-menu"), n.moreItems = n.moreMenu.find(">li").not(".js-subitem, .dropdown-header"), p = n.topItems.length, o.on("load.responsivemenu orientationchange.responsivemenu resize.responsivemenu affixed.bs.affix affixed-top.bs.affix", e(g, l.handlersDelay)), o.on("load.stickybar scroll.stickybar", e(j, l.handlersDelay))
        }, e = function(a, b, c) {
            b = b || l.handlersDelay;
            var d, e;
            return function() {
                var f = this,
                    g = +new Date,
                    h = arguments;
                c && (d = g), d && d + b > g ? (clearTimeout(e), e = setTimeout(function() {
                    d = g, a.apply(f, h)
                }, b)) : (d = g, a.apply(f, h))
            }
        }, g = function() {
            n.topItems = n.nav.find(">li").not(".moremenu"), n.moreItems = n.moreMenu.find(">li").not(".js-subitem, .dropdown-header");
            var b = n.nav.outerWidth(),
                c = n.moreBtn.is(":visible") ? n.moreBtn.outerWidth() : 0;
            n.topItems.each(function() {
                c += a(this).outerWidth()
            });
            var d = 0,
                e = 0;
            if (c > b) d = n.moreBtn.outerWidth(), n.topItems.each(function(c, f) {
                return d += a(f).outerWidth(), d > b ? (e = c - 1, !1) : void 0
            }), n.topItems.filter(function(a) {
                return a > e
            }).reverse().each(function() {
                var b = a(this);
                b.hasClass("dropdown") ? h(b) : b.prependTo(n.moreMenu)
            }), n.moreBtn.show();
            else {
                var f = n.topItems.length;
                n.moreItems.each(function(e, g) {
                    if (!(p > f)) return !1;
                    var j = a(g);
                    return j.hasClass("js-was-dropdown") ? i(j) : j.insertBefore(n.moreBtn), d = c + j.outerWidth(), d > b ? (j.hasClass("dropdown") ? h(j) : j.prependTo(n.moreMenu), !1) : (f++, void(c = d))
                }), 0 === n.moreMenu.children().length && n.moreBtn.hide()
            }
        }, h = function(b) {
            var c = b.data("title");
            b.removeClass().addClass("js-was-dropdown"), b.find(">a").removeClass().removeAttr("role").removeAttr("data-toggle").removeData("toggle");
            var d = b.find(".dropdown-menu"),
                e = d.find(">li").detach();
            d.remove(), b.prependTo(n.moreMenu).css("display", "none"), e.reverse().each(function() {
                a(this).addClass("js-subitem").attr("data-parent", c).insertAfter(b)
            }), a('<li class="dropdown-header"></li>').attr("data-parent", c).text(c).insertAfter(b)
        }, i = function(b) {
            var c = b.data("title"),
                d = n.moreMenu.find('.js-subitem[data-parent="' + c + '"]');
            n.moreMenu.find('.dropdown-header[data-parent="' + c + '"]').remove(), b.removeClass().addClass("dropdown").removeAttr("style"), b.find(">a").attr({
                role: "button",
                "data-toggle": "dropdown"
            }).data("toggle", "dropdown").addClass("doprdown-toggle");
            var e = a('<ul class="dropdown-menu"></ul>').appendTo(b);
            d.appendTo(e), b.insertBefore(n.moreBtn)
        }, j = function() {
            o.scrollTop() >= l.stickyThreshold ? (m.addClass("affix").removeClass("affix-top"), o.trigger("affixed.bs.affix")) : (m.addClass("affix-top").removeClass("affix"), o.trigger("affixed-top.bs.affix"))
        }, k
    }, jQuery.fn.reverse = Array.prototype.reverse
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = d.core.getInstance(),
        g = {
            baseUrl: "",
            emptyValue: !1,
            version: 1,
            language: "en"
        };
    e.favouriteloader = function(c, e) {
        var h, i = this,
            j = a.extend(!0, {}, g, e || {}),
            k = c,
            l = {};
        i.init = function() {
            i.oldTeamId = -1, m(), a(b).off("changefavourite", m).on("changefavourite", m)
        };
        var m = function() {
                !h && d.favouriteTeam && (h = new d.favouriteTeam), h.getFavouriteTeamId().then(function(c) {
                    var d = (b.CMSPath || "") + j.baseUrl;
                    d.indexOf("[TEAMID]") > 0 ? d = d.replace("[TEAMID]", c) : d += c > 0 ? c : "", i.oldTeamId !== c && (i.oldTeamId = c, k.fadeOut("fast"), (j.emptyValue === !1 || c > 0) && a.get(d, function(a) {
                        k.html(a), l.moreContent = k.find(".more-news-section"), l.moreBtn = k.find(".showhide-btn"), l.moreContent.addClass("hidden"), l.moreBtn.on("click", function() {
                            l.moreContent.hasClass("hidden") && n()
                        })
                    }).fail(function() {
                        i.oldTeamId = -1
                    }).always(function() {
                        k.fadeIn(function() {
                            "function" == typeof k.find(".pflazyload").pflazyload && k.find(".pflazyload").pflazyload(300), f.parse(k), h.setFavouriteClass(c)
                        })
                    }))
                })
            },
            n = function() {
                l.moreContent.removeClass("hidden").addClass("visible"), l.moreBtn.parents(".section--footer").removeClass("visible").addClass("hidden"), "function" == typeof l.moreContent.find(".pflazyload").pflazyload && l.moreContent.find(".pflazyload").pflazyload(300)
            }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1
        });
    e.hpmatchescarousel = function(b, g) {
        var h, i, j, k, l, m, n, o = this,
            p = a.extend(!0, {}, f, g || {}),
            q = b,
            r = !1;
        this.init = function() {
            if (h = a("#" + p.contentCarousel), i = a("#" + p.pickOfTheWeek), j = a("#" + p.mcSummary), k = a("#potw"), m = h.length > 0, n = j.length > 0, k.parents(".matchlist__carousel").toggleClass("potw", m), l = q.find(".item"), a.each(l, function(b, c) {
                    if (e.tolocaltime) {
                        var d = a(c),
                            f = d.data("options"),
                            g = new e.tolocaltime(d, f);
                        g.init(function() {
                            var a = d.find(".item-date").text(),
                                c = 0 === b ? "" : l.eq(b - 1).find(".item-date").text();
                            a != c && d.addClass("date")
                        })
                    }
                }), q.owlCarousel(p), m) {
                var b = a.extend(!0, h.data("options"), {
                    afterAction: v,
                    startDragging: function(a) {
                        var b = this.owl.currentItem + 1,
                            c = this.owl.currentItem - 1;
                        if (b < this.owl.owlItems.length) {
                            var d = q.find(".owl-item").eq(b);
                            s(d, !0)
                        }
                        if (c >= 0) {
                            var e = q.find(".owl-item").eq(c);
                            s(e, !0)
                        }
                    },
                    afterInit: function() {
                        k.on("click", "a", function(a) {
                            a.preventDefault(), t()
                        }), t()
                    }
                });
                h.owlCarousel(b), q.on("click", ".owl-item", function(b) {
                    b.preventDefault();
                    var c = a(this);
                    m && s(c, !1)
                })
            } else n && (d.MatchControl = new d.Uefacom.MatchHandler(d.Uefacom.MHdata), d.MatchControl.register(d.Uefacom.MHregister));
            var c = l.index(q.find(".item.first"));
            q.trigger("owl.jumpTo", c)
        };
        var s = function(b, d) {
                var e = b.data("owlItem"),
                    f = b.find(".match").data("link"),
                    g = h.find(".item").eq(e);
                f = "/2016" + f.replace("index.html", "library/_hpTopContent.html"), (r === !1 || d) && (g.hasClass("loaded") === !1 ? (r = !0, a.ajax({
                    url: f,
                    cache: !1
                }).done(function(a) {
                    g.html(a), d === !1 && h.data("owlCarousel") !== c && h.trigger("owl.goTo", e)
                }).complete(function() {
                    r = !1, u()
                })) : d === !1 && (h.data("owlCarousel") !== c && e != h.data("owlCarousel").currentItem && h.trigger("owl.goTo", e), u()))
            },
            t = function() {
                h.parents(".section").fadeOut(), q.find(".owl-item").removeClass("synced"), k.addClass("synced"), i.fadeIn()
            },
            u = function() {
                i.fadeOut(), k.removeClass("synced"), q.find(".owl-item").eq(h.data("owlCarousel").currentItem).addClass("synced"), h.parents(".section").fadeIn(function() {
                    x()
                })
            },
            v = function(a) {
                if (!k.hasClass("synced")) {
                    var b = this.currentItem,
                        d = h.find(".owl-item").eq(b),
                        e = q.find(".owl-item").eq(b);
                    h.find(".owl-item").removeClass("synced"), q.find(".owl-item").removeClass("synced"), d.addClass("synced"), e.addClass("synced"), q.data("owlCarousel") !== c && w(b)
                }
                x()
            },
            w = function(a) {
                var b = q.data("owlCarousel").owl.visibleItems,
                    c = a,
                    d = !1;
                for (var e in b) c === b[e] && (d = !0);
                d === !1 ? c > b[b.length - 1] ? q.trigger("owl.goTo", c - b.length + 2) : (c - 1 === -1 && (c = 0), q.trigger("owl.goTo", c)) : c === b[b.length - 1] ? q.trigger("owl.goTo", b[1]) : c === b[0] && q.trigger("owl.goTo", c - 1)
            },
            x = function() {
                h.find(".owl-item.synced .article--img--topcontent").on("load", function() {
                    var b = this;
                    b.naturalWidth <= 1 && (b.src = a(b).data("voidurl"))
                })
            };
        return o
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1,
            items: 4,
            itemsDesktop: [1199, 4],
            itemsTablet: [768, 3],
            itemsTabletSmall: [767, 2],
            itemsMobile: [549, 1],
            pagination: !1,
            uefa_pagination: !0,
            slideSpeed: 1e3,
            navigation: !0,
            scrollPerPage: !0,
            minwidth: !1
        });
    e.responsivecarousel = function(c, d) {
        var e = this,
            g = a.extend(!0, {}, f, d || {}),
            h = c,
            i = {};
        i.pagination = a("<div>").addClass("uefa-owl-pagination"), i.items = [];
        var j, k, l, m, n, o, p, q;
        return this.init = function() {
            k = h.find(".pflazyload").length > 0, g = a.extend(!0, g, {
                afterInit: l,
                afterMove: m,
                afterUpdate: m,
                afterLazyLoad: n,
                lazyEffect: !1,
                lazyLoad: k
            }), h.addClass("owl-carousel"), h.owlCarousel(g);
            var c = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            q(c > g.minwidth || !g.minwidth), a(b).on("orientationchange.responsivecarousel resize.responsivecarousel", o(p))
        }, l = function() {
            g.uefa_pagination && (j = this, i.controls = h.find(".owl-buttons"), i.controls.append(i.pagination), m())
        }, m = function() {
            if (g.uefa_pagination) {
                var a = Math.ceil((j.owl.currentItem + 1) / j.options.items),
                    b = Math.ceil(j.itemsAmount / j.options.items);
                j.owl.currentItem === j.maximumItem && (a = b), 1 === a && 0 !== j.owl.currentItem && a++, a = a >= 10 ? a : "0" + a, b = b >= 10 ? b : "0" + b, i.pagination.empty().append('<span class="page--current">' + a + '</span><span class="page--total">/' + b + "</span>")
            }
        }, n = function(c) {
            k && a(b).trigger("move.carousel")
        }, p = function() {
            var a = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            q(a > g.minwidth)
        }, q = function(b) {
            b ? h.hasClass("owl-carousel") || (h.addClass("owl-carousel"), a.each(i.items, function(b, c) {
                var d = a(c),
                    e = a(".item" + b, h).detach();
                d.append(e), h.append(d)
            }), h.owlCarousel(g)) : h.hasClass("owl-carousel") && h.data("owlCarousel") && (h.data("owlCarousel").destroy(), a(".item", h).each(function(b) {
                var c = a(this),
                    d = a(">div", c).addClass("item" + b).detach();
                h.append(d), i.items.push(c.detach())
            }), h.removeClass("owl-carousel"))
        }, o = function(a, b, c) {
            b = b || g.responsiveRefreshRate;
            var d, e;
            return function() {
                var f = this,
                    g = +new Date,
                    h = arguments;
                c && (d = g), d && d + b > g ? (clearTimeout(e), e = setTimeout(function() {
                    d = g, a.apply(f, h)
                }, b)) : (d = g, a.apply(f, h))
            }
        }, e
    }
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre.plugins,
        d = {
            className: "more--opened"
        };
    c.dropdown = function(c, e) {
        var f = a.extend(!0, {}, d, e || {}),
            g = c,
            h = !0,
            i = function(a, b, c) {
                var d;
                return function() {
                    var e = this,
                        f = arguments,
                        g = function() {
                            d = null, c || a.apply(e, f)
                        },
                        h = c && !d;
                    clearTimeout(d), d = setTimeout(g, b), h && a.apply(e, f)
                }
            };
        this.init = function() {
            var c = g.offset().top,
                d = a(g.attr("href") + ".collapse"),
                e = a(g.attr("href")).parent();
            g.on("click", function() {
                e = a(g.attr("href")).parent(), g.toggleClass(f.className), g.hasClass(f.className) === !1 ? a(b).scrollTop(c - b.innerHeight / 2) : d.on("shown.bs.collapse", i(function() {
                    h && (a(" .pflazyload", d).pflazyload(300), h = !1)
                }, 200))
            })
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = b.Deltatre,
        e = d.plugins,
        f = (d.Trace, {
            version: 1,
            handlersDelay: 100,
            stickyThreshold: 100,
            disableStickyHeader: !1,
            desktopBreakpoint: 960
        });
    e.navigation = function(c, d) {
        var e, g, h, i, j = a.extend(!0, {}, f, d || {}),
            k = c,
            l = {},
            m = a(b),
            n = 0,
            o = 0;
        this.init = function() {
            l.navigation = a(".navigation"), l.wrapper = k.find(".js-nav-wrap"), l.toggle = l.wrapper.find(".js-toggle"), l.compNav = l.wrapper.find(".js-nav"), l.allNavs = l.navigation.find(".js-nav-wrap"), l.sectionNav = a(".navigation .js-section-nav"), l.sectionNav.length > 0 ? (l.sectionNav.before(l.toggle.clone()).after(l.compNav.clone()), l.wrapper = l.sectionNav.parents(".js-nav-wrap"), l.toggle = l.wrapper.find(".js-toggle")) : l.wrapper.addClass("navbar-lv2-only"), l.toggle.on("click", function(a) {
                a.preventDefault(), l.wrapper.toggleClass("open")
            }), l.sectionNav.length > 0 && m.on("load.sectionmenu resize.sectionmenu", e(h, j.handlersDelay)), "true" != j.disableStickyHeader.toString().toLowerCase() && m.on("load.stickybar scroll.stickybar", e(g, j.handlersDelay))
        }, e = function(a, b) {
            b = b || j.handlersDelay;
            var c, d;
            return function() {
                var e = this,
                    f = +new Date,
                    g = arguments;
                c && c + b > f ? (clearTimeout(d), d = setTimeout(function() {
                    c = f, a.apply(e, g)
                }, b)) : (c = f, a.apply(e, g))
            }
        }, g = function() {
            o = l.navigation.outerHeight(), j.stickyThreshold = l.navigation.offset().top + o;
            var a = m.scrollTop();
            n > a && a >= j.stickyThreshold ? l.allNavs.hasClass("affix") || (l.allNavs.addClass("affix"), l.navigation.css("height", o)) : (a >= n + 20 || a < j.stickyThreshold) && l.allNavs.hasClass("affix") && (l.allNavs.removeClass("affix"), l.navigation.css("height", "")), i(), n = a
        }, h = function() {
            if (m.width() >= j.desktopBreakpoint) {
                var b = 0;
                l.sectionNav.find("li").each(function() {
                    b += a(this).outerWidth()
                });
                var c = l.sectionNav.width();
                l.toggle.toggleClass("hidden-md hidden-lg", c >= b)
            }
        }, i = function() {
            l.cookiepolicy = a(".cc_banner-wrapper"), l.cookiepolicydismiss = l.cookiepolicy.find(".cc_btn_accept_all"), m.scrollTop() >= j.stickyThreshold ? l.cookiepolicy.size() > 0 && (m.width() <= j.desktopBreakpoint ? l.wrapper.css("top", l.cookiepolicy.innerHeight() - 8) : l.wrapper.css("top", l.cookiepolicy.innerHeight() - 1)) : l.wrapper.css("top", 0), l.cookiepolicydismiss.on("click", function() {
                l.wrapper.css("top", 0)
            }), a(b).resize(function() {
                m.width() <= j.desktopBreakpoint && l.wrapper.css("top", l.cookiepolicy.innerHeight() - 8)
            })
        }
    }
}(jQuery, window),
function(a, b) {
    "use strict";
    var c = b.Deltatre.plugins;
    c.datatables = function(b, c) {
        var d = {
            paging: !1,
            info: !1,
            searching: !1,
            stateSave: !1,
            scrollX: "65%",
            autoWidth: !0,
            columnDefs: [],
            order: []
        };
        a(b).find("thead tr th").each(function(b, c) {
            if (a(c).attr("data-table-width") && d.columnDefs.push({
                    width: a(c).attr("data-table-width"),
                    targets: b
                }), a(c).attr("data-table-sort")) {
                var e = a(c).attr("data-table-sort").split(",");
                d.order.push([e[0], e[1]])
            }
        }), c = a.extend(!0, {}, d, c || {}), this.init = function() {
            var d = a(b).DataTable(c);
            new a.fn.dataTable.FixedColumns(d, {})
        }
    }
}(jQuery, window),
function(a, b) {
    var c = b.Deltatre.plugins;
    c.adaptiveincluder = function(b, c) {
        var d = {
            offset: 25
        };
        c = a.extend(!0, {}, d, c || {});
        var e = function() {
                var d = a(b).contents().find("html").outerHeight(!0) + c.offset;
                a(b).css("height", d)
            },
            f = function(a, b) {
                return setTimeout(function() {
                    e(), b && b()
                }, a)
            },
            g = function(a) {
                f(25, a)
            },
            h = function(a) {
                f(200, a)
            },
            i = function(a) {
                f(650, a)
            };
        this.init = function() {
            a(b).on("load", function() {
                a(b).contents().find("body").css({
                    margin: 0
                }), e(), a(b).contents().find(".qa-question-link").on("click", function() {
                    g()
                }), a(b).contents().find(".qa-node").on("click", ".qa-close-form", function() {
                    g()
                }), a(b).contents().find("#qa-live-search-submit").on("click", function() {
                    g()
                }), a(b).contents().find("#qa-clear").on("click", function() {
                    g()
                }), a(b).contents().find("#qa-live-search-text").on("keypress", function(a) {
                    13 == a.which && h()
                }), a(b).contents().find(".qa-satisfaction-link").on("click", function() {
                    i(function() {
                        iframeE.contents().find(".form-submit.ajax-processed").off("mousedown").one("mousedown", function() {
                            i()
                        })
                    })
                })
            })
        }
    }
}(jQuery, window),
function(a, b, c) {
    "use strict";
    var d = a.Deltatre || {},
        e = d.core.getInstance(),
        f = function(c) {
            var d = {
                viewContainerSelector: "[data-view-container]",
                animate: !0,
                routes: {}
            };
            this.options = b.extend({}, d, c), a.addEventListener("popstate", function(a) {
                this.onStateChange(a)
            }.bind(this), !1), b(a).on("hashchange", function() {
                this.isIE() && this.trigger("popstate", a)
            }.bind(this)), b(a.document).on("click", "[data-url]", function(a) {
                var c = b(a.currentTarget).data("url");
                this.navigateTo(c), a.stopPropagation(), a.preventDefault()
            }.bind(this)), this.init()
        };
    f.prototype.trigger = function(b, c) {
        var d;
        a.document.createEvent ? (d = document.createEvent("HTMLEvents"), d.initEvent(b, !0, !0)) : (d = document.createEventObject(), d.eventType = b), d.eventName = b, document.createEvent ? c.dispatchEvent(d) : c.fireEvent("on" + d.eventType, d)
    }, f.prototype.navigateTo = function(b) {
        if (!b) throw new Error("Invalid bit");
        var c = b;
        return Array.prototype.slice.call(arguments, 1).forEach(function(a) {
            c += "/" + a
        }), a.location.hash = c, this.isIE() && this.trigger("popstate", a), !1
    }, f.prototype.log = function() {
        a.console && a.console.log(arguments)
    }, f.prototype.isIE = function(a) {
        return a = a || navigator.userAgent, a.indexOf("MSIE ") > -1 || a.indexOf("Trident/") > -1
    }, f.prototype.onStateChange = function() {
        var c = a.document.location.hash || "#home",
            d = null;
        d = b.isArray(c) ? c[0] : c;
        var e = d.split("/"),
            f = e.splice(0, 1)[0];
        f.match(/^#.*/) && (f = f.substring(1)), f = f || "home";
        var g = null;
        if (this.options.routes.hasOwnProperty(f)) {
            var h = this.options.routes[f];
            g = h.apply(this, e)
        } else this.log("No route found for hash " + d);
        g ? b(this.options.viewContainerSelector).fadeTo(100, this.options.animate ? .2 : 1, function() {
            b.when(g).done(function(a) {
                this.loadView(f, a)
            }.bind(this))
        }.bind(this)) : this.loadView(f, g)
    }, f.prototype.init = function() {
        this.trigger("popstate", a)
    }, f.prototype.loadView = function(d, f) {
        if (f !== !1) {
            var g = "script#" + d,
                h = this.options.animate,
                i = b(this.options.viewContainerSelector);
            if (b(g).length) {
                var j = b(g).text(),
                    k = c.template(j);
                i.fadeTo(100, h ? .2 : 1, function() {
                    i.html(k(f || {})), e.parse(i), b(document).scrollTop(i.offset().top - b(a).height() / 10), i.fadeTo("fast", 1), b(document).trigger("navigate:to", d)
                })
            } else this.log("No view found with id " + d)
        }
    }, d.Router = f
}(window, jQuery, _);