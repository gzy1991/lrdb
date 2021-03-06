define(["jquery","PDUtilDir/util","Ace-extra"],function($,util){

    /**
     Required. Ace's Basic File to Initiliaze Different Parts & Some Variables.
     */
    if( !('ace' in window) ) window['ace'] = {}
    if( !('helper' in window['ace']) ) window['ace'].helper = {}
    if( !('vars' in window['ace']) ) {
        window['ace'].vars = {
            'icon'	: ' ace-icon ',
            '.icon'	: '.ace-icon'
        }
    }
    ace.vars['touch']	= 'ontouchstart' in document.documentElement;


    ace.init = function(){

        //sidebar控制
        ace.settings.check('sidebar' , 'collapsed');


        //sometimes we try to use 'tap' event instead of 'click' if jquery mobile plugin is available
        ace.click_event = ace.vars['touch'] && $.fn.tap ? 'tap' : 'click';

        //sometimes the only good way to work around browser's pecularities is to detect them using user-agents
        //though it's not accurate
        var agent = navigator.userAgent
        ace.vars['webkit'] = !!agent.match(/AppleWebKit/i)
        ace.vars['safari'] = !!agent.match(/Safari/i) && !agent.match(/Chrome/i);
        ace.vars['android'] = ace.vars['safari'] && !!agent.match(/Android/i)
        ace.vars['ios_safari'] = !!agent.match(/OS ([4-8])(_\d)+ like Mac OS X/i) && !agent.match(/CriOS/i)

        ace.vars['non_auto_fixed'] = ace.vars['android'] || ace.vars['ios_safari'];
        // for android and ios we don't use "top:auto" when breadcrumbs is fixed
        if(ace.vars['non_auto_fixed']) {
            $('body').addClass('mob-safari');
        }

        ace.vars['transition'] = 'transition' in document.body.style || 'WebkitTransition' in document.body.style || 'MozTransition' in document.body.style || 'OTransition' in document.body.style

        /////////////////////////////

        //a list of available functions with their arguments
        // >>> null means enable
        // >>> false means disable
        // >>> array means function arguments
        var available_functions = {
            'general_vars' : null,//general_vars should come first

            'handle_side_menu' : null,
            'add_touch_drag' : null,

            'sidebar_scrollable' : [
                //true, //enable only if sidebar is fixed , for 2nd approach only
                true //scroll to selected item? (one time only on page load)
                ,true //true = include shortcut buttons in the scrollbars
                ,false || ace.vars['safari'] || ace.vars['ios_safari'] //true = include toggle button in the scrollbars
                ,200 //> 0 means smooth_scroll, time in ms, used in first approach only, better to be almost the same amount as submenu transition time
                ,false//true && ace.vars['touch'] //used in first approach only, true means the scrollbars should be outside of the sidebar
            ],

            'sidebar_hoverable' : null,//automatically move up a submenu, if some part of it goes out of window
            'sidebar_click':null,

            'general_things' : null,

            'widget_boxes' : null,
            'widget_reload_handler' : null,

            'settings_box' : null,//settings box
            'settings_rtl' : null,
            'settings_skin' : null,

            'enable_searchbox_autocomplete' : null,

            'auto_hide_sidebar' : null,//disable?
            'auto_padding' : null,//disable
            'auto_container' : null//disable
        };


        //enable these functions with related params
        for(var func_name in available_functions) {

            if(!(func_name in ace)) continue;
            var args = available_functions[func_name];
            if(args === false) continue;//don't run this function

            else if(args == null) args = [jQuery];
            else if(args instanceof String) args = [jQuery, args];
            else if(args instanceof Array) args.unshift(jQuery);//prepend jQuery

            ace[func_name].apply(null, args);
        }

    };



    ace.general_vars = function($) {
        var minimized_menu_class  = 'menu-min';
        var responsive_min_class  = 'responsive-min';
        var horizontal_menu_class = 'h-sidebar';

        var sidebar = $('#sidebar').eq(0);
        //differnet mobile menu styles
        ace.vars['mobile_style'] = 1;//default responsive mode with toggle button inside navbar
        if(sidebar.hasClass('responsive') && !$('#menu-toggler').hasClass('navbar-toggle')) ace.vars['mobile_style'] = 2;//toggle button behind sidebar
        else if(sidebar.hasClass(responsive_min_class)) ace.vars['mobile_style'] = 3;//minimized menu
        else if(sidebar.hasClass('navbar-collapse')) ace.vars['mobile_style'] = 4;//collapsible (bootstrap style)

        //update some basic variables
        $(window).on('resize.ace.vars' , function(){
            ace.vars['window'] = {width: parseInt($(this).width()), height: parseInt($(this).height())}
            ace.vars['mobile_view'] = ace.vars['mobile_style'] < 4 && ace.helper.mobile_view();
            ace.vars['collapsible'] = !ace.vars['mobile_view'] && ace.helper.collapsible();
            ace.vars['nav_collapse'] = (ace.vars['collapsible'] || ace.vars['mobile_view']) && $('#navbar').hasClass('navbar-collapse');

            var sidebar = $(document.getElementById('sidebar'));
            ace.vars['minimized'] =
                (!ace.vars['collapsible'] && sidebar.hasClass(minimized_menu_class))
                ||
                (ace.vars['mobile_style'] == 3 && ace.vars['mobile_view'] && sidebar.hasClass(responsive_min_class))

            ace.vars['horizontal'] = !(ace.vars['mobile_view'] || ace.vars['collapsible']) && sidebar.hasClass(horizontal_menu_class)
        }).triggerHandler('resize.ace.vars');
    };

//
    ace.general_things = function($) {
        //add scrollbars for user dropdowns
        var has_scroll = !!$.fn.ace_scroll;
        if(has_scroll) $('.dropdown-content').ace_scroll({reset: false, mouseWheelLock: true})
        /**
         //add scrollbars to body
         if(has_scroll) $('body').ace_scroll({size: ace.helper.winHeight()})
         $('body').css('position', 'static')
         */

            //reset scrolls bars on window resize
        $(window).on('resize.reset_scroll', function() {
            /**
             //reset body scrollbars
             if(has_scroll) $('body').ace_scroll('update', {size : ace.helper.winHeight()})
             */
            if(has_scroll) $('.ace-scroll').ace_scroll('reset');
        });
        $(document).on('settings.ace.reset_scroll', function(e, name) {
            if(name == 'sidebar_collapsed' && has_scroll) $('.ace-scroll').ace_scroll('reset');
        });


        //change a dropdown to "dropup" depending on its position
        $(document).on('click.dropdown.pos', '.dropdown-toggle[data-position="auto"]', function() {
            var offset = $(this).offset();
            var parent = $(this.parentNode);

            if ( parseInt(offset.top + $(this).height()) + 50
                >
                (ace.helper.scrollTop() + ace.helper.winHeight() - parent.find('.dropdown-menu').eq(0).height())
                ) parent.addClass('dropup');
            else parent.removeClass('dropup');
        });


        //prevent dropdowns from hiding when a tab is selected
        $(document).on('click', '.dropdown-navbar .nav-tabs', function(e){
            e.stopPropagation();
            var $this , href
            var that = e.target
            if( ($this = $(e.target).closest('[data-toggle=tab]')) && $this.length > 0) {
                $this.tab('show');
                e.preventDefault();
            }
        });

        //prevent dropdowns from hiding when a from is clicked
        /**$(document).on('click', '.dropdown-navbar form', function(e){
		e.stopPropagation();
	});*/


            //disable navbar icon animation upon click
        $('.ace-nav [class*="icon-animated-"]').closest('a').one('click', function(){
            var icon = $(this).find('[class*="icon-animated-"]').eq(0);
            var $match = icon.attr('class').match(/icon\-animated\-([\d\w]+)/);
            icon.removeClass($match[0]);
        });


        //tooltip in sidebar items
        $('.sidebar .nav-list .badge[title],.sidebar .nav-list .badge[title]').each(function() {
            var tooltip_class = $(this).attr('class').match(/tooltip\-(?:\w+)/);
            tooltip_class = tooltip_class ? tooltip_class[0] : 'tooltip-error';
            $(this).tooltip({
                'placement': function (context, source) {
                    var offset = $(source).offset();

                    if( parseInt(offset.left) < parseInt(document.body.scrollWidth / 2) ) return 'right';
                    return 'left';
                },
                container: 'body',
                template: '<div class="tooltip '+tooltip_class+'"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
            });
        });

        //or something like this if items are dynamically inserted
        /**$('.sidebar').tooltip({
		'placement': function (context, source) {
			var offset = $(source).offset();

			if( parseInt(offset.left) < parseInt(document.body.scrollWidth / 2) ) return 'right';
			return 'left';
		},
		selector: '.nav-list .badge[title],.nav-list .label[title]',
		container: 'body',
		template: '<div class="tooltip tooltip-error"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
	});*/




        //the scroll to top button
        var scroll_btn = $('.btn-scroll-up');
        if(scroll_btn.length > 0) {
            var is_visible = false;
            $(window).on('scroll.scroll_btn', function() {
                if(ace.helper.scrollTop() > parseInt(ace.helper.winHeight() / 4)) {
                    if(!is_visible) {
                        scroll_btn.addClass('display');
                        is_visible = true;
                    }
                } else {
                    if(is_visible) {
                        scroll_btn.removeClass('display');
                        is_visible = false;
                    }
                }
            }).triggerHandler('scroll.scroll_btn');

            scroll_btn.on(ace.click_event, function(){
                var duration = Math.min(500, Math.max(100, parseInt(ace.helper.scrollTop() / 3)));
                $('html,body').animate({scrollTop: 0}, duration);
                return false;
            });
        }


        //chrome and webkit have a problem here when resizing from 460px to more
        //we should force them redraw the navbar!
        if( ace.vars['webkit'] ) {
            var ace_nav = $('.ace-nav').get(0);
            if( ace_nav ) $(window).on('resize.webkit' , function(){
                ace.helper.redraw(ace_nav);
            });
        }

    };




//some functions
    ace.helper.collapsible = function() {
        var toggle
        return (document.querySelector('#sidebar.navbar-collapse') != null)
            && ((toggle = document.querySelector('.navbar-toggle[data-target*=".sidebar"]')) != null)
            &&  toggle.scrollHeight > 0
        //sidebar is collapsible and collapse button is visible?
    }
    ace.helper.mobile_view = function() {
        var toggle
        return ((toggle = document.getElementById('menu-toggler')) != null	&& toggle.scrollHeight > 0)
    }

    ace.helper.redraw = function(elem) {
        var saved_val = elem.style['display'];
        elem.style.display = 'none';
        elem.offsetHeight;
        elem.style.display = saved_val;
    }

    ace.helper.scrollTop = function() {
        return document.scrollTop || document.documentElement.scrollTop || document.body.scrollTop
        //return $(window).scrollTop();
    }
    ace.helper.winHeight = function() {
        return window.innerHeight || document.documentElement.clientHeight;
        //return $(window).innerHeight();
    }
    ace.helper.camelCase = function(str) {
        return str.replace(/-([\da-z])/gi, function(match, chr) {
            return chr ? chr.toUpperCase() : '';
        });
    }
    ace.helper.removeStyle =
            'removeProperty' in document.body.style
        ?
        function(elem, prop) { elem.style.removeProperty(prop) }
        :
        function(elem, prop) { elem.style[ace.helper.camelCase(prop)] = '' }


    ace.helper.hasClass =
            'classList' in document.documentElement
        ?
        function(elem, className) { return elem.classList.contains(className); }
        :
        function(elem, className) { return elem.className.indexOf(className) > -1; };

    /**
     <b>Sidebar functions</b>. Collapsing/expanding, toggling mobile view menu and other sidebar functions.
     */

    ace.handle_side_menu = function($) {
        var sidebar = $('.sidebar').eq(0);

        //$(document).on(ace.click_event+'.ace.menu', '#menu-toggler', function(){
        $("#sidebar").on(ace.click_event+'.ace.menu', '#menu-toggler', function(){
            sidebar.toggleClass('display');
            $(this).toggleClass('display');

            if( $(this).hasClass('display') && 'sidebar_scroll' in ace.helper )
            {
                ace.helper.sidebar_scroll.reset();
            }

            return false;
        })
            //sidebar collapse/expand button
            .on(ace.click_event+'.ace.menu', '.sidebar-collapse', function(){
                if(ace.vars['collapsible'] || ace.vars['horizontal']) return;

                //var minimized = sidebar.hasClass('menu-min');
                ace.vars['minimized'] = !ace.vars['minimized'];
                ace.settings.sidebar_collapsed.call(this, ace.vars['minimized']);//@ ace-extra.js
                //ace.settings.sidebar_collapsed(ace.vars['minimized']);
            })
            //this button is used in `mobile_style = 3` responsive menu style to expand minimized sidebar
            .on(ace.click_event+'.ace.menu', '.sidebar-expand', function(){

                if( ace.vars['minimized'] /**sidebar.hasClass('menu-min')*/ ) {
                    ace.settings.sidebar_collapsed.call(this, false , false);
                    //unminimize (remove .menu-min) but don't save changes to cookies
                }

                var icon = $(this).find(ace.vars['.icon']);
                var $icon1 = icon.attr('data-icon1');//the icon for expanded state
                var $icon2 = icon.attr('data-icon2');//the icon for collapsed state
                if( sidebar.hasClass('responsive-min') ) {
                    icon.removeClass($icon1).addClass($icon2);
                    sidebar.removeClass('responsive-min');
                    sidebar.addClass('display responsive-max');

                    ace.vars['minimized'] = false
                }
                else {
                    icon.removeClass($icon2).addClass($icon1);
                    sidebar.removeClass('display responsive-max');
                    sidebar.addClass('responsive-min');

                    ace.vars['minimized'] = true
                }

                $(document).triggerHandler('settings.ace', ['sidebar_collapsed' , ace.vars['minimized']]);
            });



        //ios safari only has a bit of a problem not navigating to link address when scrolling down
        var ios_fix = ace.vars['ios_safari'];//navigator.userAgent.match(/OS (5|6|7)(_\d)+ like Mac OS X/i);
        //toggling submenu
        $(document).on(ace.click_event+'.ace.submenu', '.sidebar .nav-list', function (ev) {
            var nav_list = this;

            //check to see if we have clicked on an element which is inside a .dropdown-toggle element?!
            //if so, it means we should toggle a submenu
            var link_element = $(ev.target).closest('a');
            if(!link_element || link_element.length == 0) return;//return if not clicked inside a link element

            var minimized  = ace.vars['minimized'] && !ace.vars['collapsible'];
            //if .sidebar is .navbar-collapse and in small device mode, then let minimized be uneffective

            if( !link_element.hasClass('dropdown-toggle') ) {//it doesn't have a submenu return
                //just one thing before we return
                //if sidebar is collapsed(minimized) and we click on a first level menu item
                //and the click is on the icon, not on the menu text then let's cancel event and cancel navigation
                //Good for touch devices, that when the icon is tapped to see the menu text, navigation is cancelled
                //navigation is only done when menu text is tapped

                if( ace.click_event == "tap"
                    &&
                    minimized
                    &&
                    link_element.get(0).parentNode.parentNode == nav_list )//only level-1 links
                {
                    var text = link_element.find('.menu-text').get(0);
                    if( ev.target != text && !$.contains(text , ev.target) ) {//not clicking on the text or its children
                        ev.preventDefault();
                        return false;
                    }
                }

                //some browsers need to be forced
                if(ios_fix && link_element.attr('data-link') !== 'false') {//specify data-link attribute to ignore this
                    //ios safari only has a bit of a problem not navigating to link address when scrolling down
                    //please see issues section
                    document.location = link_element.attr('href');
                    ev.preventDefault();
                    return false;
                }
                return;
            }


            var sub = link_element.siblings('.submenu').get(0);
            if(!sub) return false;

            var height_change = 0;//the amount of height change in .nav-list
            var duration = 250;//transition duration

            var parent_ul = sub.parentNode.parentNode;
            if
                (
                ( minimized && parent_ul == nav_list )
                ||
                ( $(sub.parentNode).hasClass('hover') && !ace.vars['collapsible'] )
                )
            {
                ev.preventDefault();
                return false;
            }

            //if not open and visible, let's open it and make it visible
            if( sub.scrollHeight == 0 ) {
                $(parent_ul).find('> .open > .submenu').each(function() {
                    //close all other open submenus except for the active one
                    if(this != sub && !$(this.parentNode).hasClass('active')) {
                        height_change -= this.scrollHeight;
                        ace.submenu.hide(this, duration);
                    }
                })
            }


            var toggle = 0;
            if( (toggle = ace.submenu.toggle(sub , duration)) == 1 ) {
                //== 1 means submenu is being shown
                //if a submenu is being shown and another one previously started to hide, then we may need to update/hide scrollbars
                //but if no previous submenu is being hidden, then no need to check if we need to hide the scrollbars in advance
                if(height_change != 0) height_change += sub.scrollHeight;
            } else if(toggle == -1) {
                height_change -= sub.scrollHeight;
                //== -1 means submenu is being hidden
            }

            //hide scrollbars if content is going to be small enough that scrollbars is not needed anymore
            //do this almost before submenu hiding begins
            if (height_change != 0 && 'sidebar_scroll' in ace.helper) {
                ace.helper.sidebar_scroll.prehide(height_change);
            }

            ev.preventDefault();
            return false;
        })
    }
    ;

    /**
     <b>Toggle sidebar submenus</b>. This approach uses <u>CSS3</u> transitions.
     It's a bit smoother but the transition does not work on IE9 and below and it is sometimes glitchy on Android's default browser.
     */

    //CSS3 transition version, no animation on IE9 and below
    ace.submenu = {
        show : function(sub, duration) {
            var $sub = $(sub);

            var event;
            $sub.trigger(event = $.Event('show.ace.submenu'))
            if (event.isDefaultPrevented()) return false;

            $sub
                .css({
                    height: 0,
                    overflow: 'hidden',
                    display: 'block'
                })
                .removeClass('nav-hide').addClass('nav-show')//only for window < @grid-float-breakpoint and .navbar-collapse.menu-min
                .parent().addClass('open');

            if( duration > 0 ) {
                $sub.css({height: sub.scrollHeight,
                    'transition-property': 'height',
                    'transition-duration': (duration/1000)+'s'})
            }

            var complete = function(ev) {
                ev && ev.stopPropagation();
                $sub
                    .css({'transition-property': '', 'transition-duration': '', overflow:'', height: ''})
                //if(ace.vars['webkit']) ace.helper.redraw(sub);//little Chrome issue, force redraw ;)

                if(ace.vars['transition']) $sub.off('.trans');
                $sub.trigger($.Event('shown.ace.submenu'))
            }
            if( duration > 0 && ace.vars['transition'] ) {
                $sub.one('transitionend.trans webkitTransitionEnd.trans mozTransitionEnd.trans oTransitionEnd.trans', complete);
            }
            else complete();

            //there is sometimes a glitch, so maybe retry
            if(ace.vars['android']) {
                setTimeout(function() {
                    $sub.css({overflow:'', height: ''});
                }, duration + 10);
            }

            return true;
        }
        ,
        hide : function(sub, duration) {
            var $sub = $(sub);

            var event;
            $sub.trigger(event = $.Event('hide.ace.submenu'))
            if (event.isDefaultPrevented()) return false;

            $sub
                .css({
                    height: sub.scrollHeight,
                    overflow: 'hidden'
                })
                .parent().removeClass('open');

            sub.offsetHeight;
            //forces the "sub" to re-consider the new 'height' before transition

            if( duration > 0 ) {
                $sub.css({'height': 0,
                    'transition-property': 'height',
                    'transition-duration': (duration/1000)+'s'});
            }


            var complete = function(ev) {
                ev && ev.stopPropagation();
                $sub
                    .css({display: 'none', overflow:'', height: '', 'transition-property': '', 'transition-duration': ''})
                    .removeClass('nav-show').addClass('nav-hide')//only for window < @grid-float-breakpoint and .navbar-collapse.menu-min

                if(ace.vars['transition']) $sub.off('.trans');
                $sub.trigger($.Event('hidden.ace.submenu'))
            }
            if( duration > 0 && ace.vars['transition'] ) {
                $sub.one('transitionend.trans webkitTransitionEnd.trans mozTransitionEnd.trans oTransitionEnd.trans', complete);
            }
            else complete();


            //there is sometimes a glitch, so maybe retry
            if(ace.vars['android']) {
                setTimeout(function() {
                    $sub.css({display: 'none', overflow:'', height: ''})
                }, duration + 10);
            }

            return true;
        }
        ,
        toggle : function(element, duration) {
            if( element.scrollHeight == 0 ) {//if an element is hidden scrollHeight becomes 0
                if(ace.submenu.show(element, duration)) return 1;
            } else {
                if(ace.submenu.hide(element, duration)) return -1;
            }
            return 0;
        }
    }
    ;

    //给sidebar添加事件监听，点击菜单自动更新导航条
    ace.sidebar_click = function(){
        $(".nav-list").bind("click",function(e){
            var li = null;
            e.target.nodeName.toLowerCase()=="a" ? li=e.target.parentNode : li=e.target.parentNode.parentNode;
            $('.nav-list li.active').removeClass('active');
            $(li).parents('.nav-list li').addClass('active');
            $(li).find("ul").length || $(li).addClass('active');
            //更新导航条
            var breadcrumb_items = [];
            $(li.firstChild).parents('.nav-list li').each(function() {
                var link = $(this).find('> a');
                var text = link.text();
                var href = link.attr('href');
                breadcrumb_items.push({'name': text, 'href': href});
            });
            //console.log(breadcrumb_items)
            require(["text!PDModuleDir/ace/template/breadcrumbs.html"],function(html){
                $(".breadcrumb").html(util.template(html,{items:breadcrumb_items}));
            });
        });
    };

    /**
     <b>Scrollbars for sidebar</b>. This approach can <span class="text-danger">only</span> be used on <u>fixed</u> sidebar.
     It doesn't use <u>"overflow:hidden"</u> CSS property and therefore can be used with <u>.hover</u> submenus and minimized sidebar.
     Except when in mobile view and menu toggle button is not in the navbar.
     */

    ace.sidebar_scrollable = function($ , scroll_to_active, include_shortcuts, include_toggle, smooth_scroll, scrollbars_outside) {
        if( !$.fn.ace_scroll ) return;

        var old_safari = ace.vars['safari'] && navigator.userAgent.match(/version\/[1-5]/i)
        //NOTE
        //Safari on windows has not been updated for a long time.
        //And it has a problem when sidebar is fixed&scrollable and there is a CSS3 animation inside page content.
        //Very probably windows users of safari have migrated to another browser by now!


        var $sidebar = $('.sidebar'),
            $navbar = $('.navbar'),
            $nav = $sidebar.find('.nav-list'),
            $toggle = $sidebar.find('.sidebar-toggle'),
            $shortcuts = $sidebar.find('.sidebar-shortcuts'),
            $window = $(window),

            sidebar = $sidebar.get(0),
            nav = $nav.get(0);

        if(!sidebar || !nav) return;


        var scroll_div = null,
            scroll_content = null,
            scroll_content_div = null,
            bar = null,
            ace_scroll = null;

        var is_scrolling = false,
            _initiated = false;

        var scroll_to_active = scroll_to_active || false,
            include_shortcuts = include_shortcuts || false,
            include_toggle = include_toggle || false,
            only_if_fixed = true;

        var is_sidebar_fixed =
                'getComputedStyle' in window ?
            //sidebar.offsetHeight is used to force redraw and recalculate 'sidebar.style.position' esp for webkit!
            function() { sidebar.offsetHeight; return window.getComputedStyle(sidebar).position == 'fixed' }
            :
            function() { sidebar.offsetHeight; return $sidebar.css('position') == 'fixed' }
        //sometimes when navbar is fixed, sidebar automatically becomes fixed without needing ".sidebar-fixed" class
        //currently when mobile_style == 1

        var $avail_height, $content_height;
        var sidebar_fixed = is_sidebar_fixed(),
            horizontal = $sidebar.hasClass('h-sidebar');


        var scrollbars = ace.helper.sidebar_scroll = {
            available_height: function() {
                //available window space
                var offset = $nav.parent().offset();//because `$nav.offset()` considers the "scrolled top" amount as well
                if(sidebar_fixed) offset.top -= ace.helper.scrollTop();
                return $window.innerHeight() - offset.top - ( include_toggle ? 0 : $toggle.outerHeight() );
            },
            content_height: function() {
                return nav.scrollHeight;
            },
            initiate: function(on_page_load) {
                if( _initiated ) return;
                if( !sidebar_fixed ) return;//eligible??
                //return if we want scrollbars only on "fixed" sidebar and sidebar is not "fixed" yet!

                //initiate once
                $nav.wrap('<div style="position: relative;" />');
                $nav.after('<div><div></div></div>');

                $nav.wrap('<div class="nav-wrap" />');
                if(!include_toggle) $toggle.css({'z-index': 1});
                if(!include_shortcuts) $shortcuts.css({'z-index': 99});

                scroll_div = $nav.parent().next()
                    .ace_scroll({
                        size: scrollbars.available_height(),
                        reset: true,
                        mouseWheelLock: true,
                        hoverReset: false,
                        dragEvent: true,
                        touchDrag: false//disable touch drag event on scrollbars, we'll add a custom one later
                    })
                    .closest('.ace-scroll').addClass('nav-scroll');

                ace_scroll = scroll_div.data('ace_scroll');

                scroll_content = scroll_div.find('.scroll-content').eq(0);
                scroll_content_div = scroll_content.find(' > div').eq(0);
                bar = scroll_div.find('.scroll-bar').eq(0);

                if(include_shortcuts) {
                    $nav.parent().prepend($shortcuts).wrapInner('<div />');
                    $nav = $nav.parent();
                }
                if(include_toggle) {
                    $nav.append($toggle);
                    $nav.closest('.nav-wrap').addClass('nav-wrap-t');//it just helps to remove toggle button's top border and restore li:last-child's bottom border
                }

                $nav.css({position: 'relative'});
                if( scrollbars_outside === true ) scroll_div.addClass('scrollout');

                nav = $nav.get(0);
                nav.style.top = 0;
                scroll_content.on('scroll.nav', function() {
                    nav.style.top = (-1 * this.scrollTop) + 'px';
                });
                $nav.on('mousewheel.ace_scroll DOMMouseScroll.ace_scroll', function(event){
                    //transfer $nav's mousewheel event to scrollbars
                    return scroll_div.trigger(event);
                });


                //you can also use swipe event in a similar way //swipe.nav
                var content = scroll_content.get(0);
                $nav.on('ace_drag.nav', function(event) {
                    if(!is_scrolling) return;

                    if(event.direction == 'up' || event.direction == 'down') {
                        //event.stopPropagation();

                        ace_scroll.move_bar(true);
                        move_nav = false;//update "nav.style.top" here no need to do this on('scroll.nav')!

                        var distance = event.dy;

                        //distance = parseInt(Math.min($avail_height, distance))
                        if(Math.abs(distance) > 20) distance = distance * 2;

                        if(distance != 0) {
                            content.scrollTop = content.scrollTop + distance;
                            nav.style.top = (-1 * content.scrollTop) + 'px';
                        }
                    }
                });

                //for drag only
                if(smooth_scroll) {
                    $nav.on('ace_dragStart.nav', function(event) {
                        event.stopPropagation();

                        $nav.css('transition-property', 'none');
                        bar.css('transition-property', 'none');
                    }).on('ace_dragEnd.nav', function(event) {
                        event.stopPropagation();

                        $nav.css('transition-property', 'top');
                        bar.css('transition-property', 'top');
                    });
                }



                if(old_safari && !include_toggle) {
                    var toggle = $toggle.get(0);
                    if(toggle) scroll_content.on('scroll.safari', function() {
                        ace.helper.redraw(toggle);
                    });
                }

                _initiated = true;

                //if the active item is not visible, scroll down so that it becomes visible
                //only the first time, on page load
                if(on_page_load == true) {
                    scrollbars.reset();//try resetting at first

                    if( scroll_to_active && ace_scroll.is_active() ) {
                        var $active;

                        var nav_list = $sidebar.find('.nav-list')
                        if(ace.vars['minimized'] && !ace.vars['collapsible']) {
                            $active = nav_list.find('> .active')
                        }
                        else {
                            $active = $nav.find('> .active.hover')
                            if($active.length == 0)	$active = $nav.find('.active:not(.open)')
                        }

                        var top = $active.outerHeight();

                        nav_list = nav_list.get(0);
                        var active = $active.get(0);
                        while(active != nav_list) {
                            top += active.offsetTop;
                            active = active.parentNode;
                        }

                        var scroll_amount = top - scroll_div.height();
                        if(scroll_amount > 0) {
                            nav.style.top = -scroll_amount + 'px';
                            scroll_content.scrollTop(scroll_amount);
                        }
                    }
                    scroll_to_active = false;
                }



                if( typeof smooth_scroll === 'number' && smooth_scroll > 0) {
                    $nav.css({'transition-property': 'top', 'transition-duration': (smooth_scroll / 1000).toFixed(2)+'s'})
                    bar.css({'transition-property': 'top', 'transition-duration': (smooth_scroll / 1500).toFixed(2)+'s'})

                    scroll_div
                        .on('drag.start', function(e) {
                            e.stopPropagation();
                            $nav.css('transition-property', 'none')
                        })
                        .on('drag.end', function(e) {
                            e.stopPropagation();
                            $nav.css('transition-property', 'top')
                        });
                }

                if(ace.vars['android']) {
                    //force hide address bar, because its changes don't trigger window resize and become kinda ugly
                    var val = ace.helper.scrollTop();
                    if(val < 2) {
                        window.scrollTo( val, 0 );
                        setTimeout( function() {
                            scrollbars.reset();
                        }, 20 );
                    }

                    var last_height = ace.helper.winHeight() , new_height;
                    $(window).on('scroll.ace_scroll', function() {
                        if(is_scrolling && ace_scroll.is_active()) {
                            new_height = ace.helper.winHeight();
                            if(new_height != last_height) {
                                last_height = new_height;
                                scrollbars.reset();
                            }
                        }
                    });
                }

            },

            reset: function() {
                if( !sidebar_fixed ) {
                    scrollbars.disable();
                    return;//eligible??
                }
                //return if we want scrollbars only on "fixed" sidebar and sidebar is not "fixed" yet!

                if( !_initiated ) scrollbars.initiate();
                //initiate scrollbars if not yet




                //enable if:
                //menu is not collapsible mode (responsive navbar-collapse mode which has default browser scrollbar)
                //menu is not horizontal or horizontal but mobile view (which is not navbar-collapse)
                //and available height is less than nav's height

                var enable_scroll = !ace.vars['collapsible']
                    && (!horizontal || (horizontal && ace.vars['mobile_view']))
                    && ($avail_height = scrollbars.available_height()) < ($content_height = nav.scrollHeight);

                is_scrolling = true;
                if( enable_scroll ) {
                    scroll_content_div.css({height: $content_height, width: 8});
                    scroll_div.prev().css({'max-height' : $avail_height})
                    ace_scroll.update({size: $avail_height}).enable().reset();
                }
                if( !enable_scroll || !ace_scroll.is_active() ) {
                    if(is_scrolling) scrollbars.disable();
                }
                else $sidebar.addClass('sidebar-scroll');

                //return is_scrolling;
            },
            disable : function() {
                is_scrolling = false;
                if(scroll_div) {
                    scroll_div.css({'height' : '', 'max-height' : ''});
                    scroll_content_div.css({height: '', width: ''});//otherwise it will have height and takes up some space even when invisible
                    scroll_div.prev().css({'max-height' : ''})
                    ace_scroll.disable();
                }

                if(parseInt(nav.style.top) < 0 && smooth_scroll && ace.vars['transition']) {
                    $nav.one('transitionend.trans webkitTransitionEnd.trans mozTransitionEnd.trans oTransitionEnd.trans', function() {
                        $sidebar.removeClass('sidebar-scroll');
                        $nav.off('.trans');
                    });
                } else {
                    $sidebar.removeClass('sidebar-scroll');
                }

                nav.style.top = 0;
            },
            prehide: function(height_change) {
                if(!is_scrolling || ace.vars['minimized']) return;

                if(scrollbars.content_height() + height_change < scrollbars.available_height()) {
                    scrollbars.disable();
                }
                else if(height_change < 0) {
                    //if content height is decreasing
                    //let's move nav down while a submenu is being hidden
                    var scroll_top = scroll_content.scrollTop() + height_change
                    if(scroll_top < 0) return;

                    nav.style.top = (-1 * scroll_top) + 'px';
                }
            }
        }
        scrollbars.initiate(true);//true = on_page_load

        //reset on document and window changes
        $(document).on('settings.ace.scroll', function(ev, event_name, event_val){
            if( event_name == 'sidebar_collapsed' && sidebar_fixed ) {
                scrollbars.reset();
            }
            else if( event_name === 'sidebar_fixed' || event_name === 'navbar_fixed' ) {
                //sidebar_fixed = event_val;
                sidebar_fixed = is_sidebar_fixed()

                if(sidebar_fixed && !is_scrolling) {
                    scrollbars.reset();
                }
                else if( !sidebar_fixed ) {
                    scrollbars.disable();
                }
            }
        });
        $window.on('resize.ace.scroll', function(){
            sidebar_fixed = is_sidebar_fixed()
            scrollbars.reset();
        })


        //change scrollbar size after a submenu is hidden/shown
        //but don't change if sidebar is minimized
        $sidebar.on('hidden.ace.submenu shown.ace.submenu', '.submenu', function(e) {
            e.stopPropagation();

            if(!ace.vars['minimized']) {
                //webkit has a little bit of a glitch!!!
                if(ace.vars['webkit']) setTimeout(function() { scrollbars.reset() } , 0);
                else scrollbars.reset();
            }
        });

    };

    /**
     <b>Submenu hover adjustment</b>. Automatically move up a submenu to fit into screen when some part of it goes beneath window.
     */

    ace.sidebar_hoverable = function($) {
        if( !('querySelector' in document) || !('removeProperty' in document.body.style) ) return;
        //ignore IE8 & below

        //on window resize or sidebar expand/collapse a previously "pulled up" submenu should be reset back to its default position
        //for example if "pulled up" in "responsive-min" mode, in "fullmode" should not remain "pulled up"
        ace.helper.sidebar_hover = {
            reset : function() {
                $sidebar.find('.submenu').each(function() {
                    var sub = this, li = this.parentNode;
                    if(sub) {
                        sub.style.removeProperty('top')
                        sub.style.removeProperty('bottom');

                        var menu_text = li.querySelector('.menu-text');
                        if(menu_text) {
                            menu_text.style.removeProperty('margin-top')
                        }
                    }

                    if( li.className.lastIndexOf('_up') >= 0 ) {//has .pull_up
                        $(li).removeClass('pull_up');
                    }
                });
            }
        }


        $(window).on('resize.ace_hover', function() {
            ace.helper.sidebar_hover.reset();
        })
        $(document).on('settings.ace.hover', function(e, event_name, event_val) {
            if(event_name == 'sidebar_collapsed') ace.helper.sidebar_hover.reset();
            else if(event_name == 'navbar_fixed') navbar_fixed = event_val;
        });

        ///////////////////////////////////////////////
        var $sidebar = $('.sidebar').eq(0),
            sidebar = $sidebar.get(0),
            nav_list = $sidebar.find('.nav-list').get(0);

        var $navbar = $('.navbar').eq(0),
            navbar = $navbar.get(0),
            horizontal = $sidebar.hasClass('h-sidebar'),

            navbar_fixed = $navbar.css('position') == 'fixed';

        $sidebar.find('.submenu').parent().addClass('hsub');//add .hsub (has-sub) class

        //some mobile browsers don't have mouseenter
        $sidebar.on('mouseenter.ace_hover', '.nav-list li.hsub', function (e) {
            //ignore if collapsible mode (mobile view .navbar-collapse) so it doesn't trigger submenu movements
            //or return if horizontal but not mobile_view (style 1&3)
            if( ace.vars['collapsible'] || (horizontal && !ace.vars['mobile_view']) ) return;

            var sub = this.querySelector('.submenu');
            if(sub) {
                //try to move/adjust submenu if the parent is a li.hover
                if( ace.helper.hasClass(this, 'hover') ) {

                    adjust_submenu.call(this, sub);
                }
                //or if submenu is minimized
                else if( this.parentNode == nav_list && ace.vars['minimized'] ) {

                    adjust_submenu.call(this, sub);
                }
            }
        })


        var $diff = 50;
        function adjust_submenu(sub) {
            var $sub = $(sub);
            sub.style.removeProperty('top')
            sub.style.removeProperty('bottom');

            var menu_text = null
            if( ace.vars['minimized'] && (menu_text = sub.parentNode.querySelector('.menu-text')) ) {
                //2nd level items don't have .menu-text
                menu_text.style.removeProperty('margin-top')
            }

            var off = $sub.offset();
            var scroll = ace.helper.scrollTop();
            var pull_up = false;

            var $scroll = scroll
            if( navbar_fixed ) {
                $scroll += navbar.clientHeight + 1;
                //let's avoid our submenu from going below navbar
                //because of chrome z-index stacking issue and firefox's normal .submenu over fixed .navbar flicker issue
            }


            var sub_h = sub.scrollHeight;
            if(menu_text) {
                sub_h += 40;
                off.top -= 40;
            }
            var sub_bottom = parseInt(off.top + sub_h)

            var diff
            //if the bottom of menu is going to go below visible window
            if( (diff = sub_bottom - (window.innerHeight + scroll - 50)) > 0 ) {

                //if it needs to be moved top a lot! use bottom unless it makes it go out of window top
                if(sub_h - diff < $diff && off.top - diff > $scroll ) {
                    sub.style.top = 'auto';
                    sub.style.bottom = '-10px';

                    if( menu_text ) {
                        //menu_text.style.marginTop = -(sub_h - 10)+'px';
                        menu_text.style.marginTop = -(sub_h - 50)+'px';// -10 - 40 for the above  extra 40
                        pull_up = true;
                    }
                }
                else {
                    //when top of menu goes out of browser window's top or below fixed navbar
                    if( off.top - diff < $scroll ) {
                        diff = off.top - $scroll;
                    }

                    //when bottom of menu goes above bottom of parent LI
                    /** else */
                    if(sub_bottom - diff < off.top + $diff) {
                        diff -= $diff;
                    }

                    var at_least = menu_text ? 40 : 20;//it we are going to move up less than at_least, then ignore
                    if( diff > at_least ) {
                        sub.style.top = -(diff) + 'px';
                        if( menu_text ) {
                            menu_text.style.marginTop = -(diff) + 'px';
                            pull_up = true;
                        }
                    }
                }
            }



            //pull_up means, pull the menu up a little bit, and some styling may need to change
            var pos = this.className.lastIndexOf('pull_up');//pull_up
            if (pull_up) {
                if (pos == -1)
                    this.className = this.className + ' pull_up';
            } else {
                if (pos >= 0)
                    this.className = this.className.replace(/(^|\s)pull_up($|\s)/ , '');
            }


            //again force redraw for safari!
            if( ace.vars['safari'] ) {
                ace.helper.redraw(sub)
            }

        }

    };


    return ace;
});