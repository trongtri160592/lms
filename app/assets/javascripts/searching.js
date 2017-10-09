//------------------------------------------------------------------------------------------//
//																							//
//			Tri Viet Searching add-on for TV.Pagination                              		//
//			Created by Nguyen Duc Thinh from Tri Viet International		    				//
//			thinhndse@gmail.com - www.vnsun.us												//
//																							//
//																							//
//																							//
//			v1.4 - Jul 22, 2016										    					//
//																							//
//------------------------------------------------------------------------------------------//

(function ($) {

    $.fn.tvSearching = function (options) {

        var defaults = {
            allField: true,
            unsignString: true,
            matchCase: false,
            absolute: true,
            keyword: ''
        };

        var options = $.extend(defaults, options);

        return this.each(function () {

            var selector = $(this);
            var keywordStr = options.keyword.replace(/\s+/g, ' ');
            if (!options.matchCase) {
                keywordStr = keywordStr.toLowerCase();
            }
            if (options.unsignString) {
                keywordStr = keywordStr.toUnsign();
            }

            var key = [];
            if (options.absolute) {
                var strMatch = keywordStr.match(/\"[^"]+\"/g);
                for (var i = 0; strMatch != null && i < strMatch.length; i++) {
                    key.push(strMatch[i].substr(1, strMatch[i].length - 2));
                }
                keywordStr = keywordStr.replace(/\"[^"]+\"/g, '').replace(/\"/g, '');
                key = $.merge(key, keywordStr.split(' '));
            } else {
                key = keywordStr.split(' ');
            }

            if (selector.prop("tagName") == "TABLE") {
                selector.children('tbody').children('tr').each(function () {
                    $(this).removeClass('notResult');

                    if (options.unsignString) {
                        if (options.matchCase) {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        } else {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().toLowerCase().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().toLowerCase().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        }

                    }
                    else {
                        if (options.matchCase) {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        } else {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().toLowerCase().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().toLowerCase().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        }

                    }
                });

                // show/hide the appropriate regions
                selector.children('tbody').children('tr').hide();
                selector.children('tbody').children(':not(.notResult)').show();
            }
            else {
                selector.children().each(function () {
                    $(this).removeClass('notResult');

                    if (options.unsignString) {
                        if (options.matchCase) {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        } else {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().toLowerCase().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().toLowerCase().toUnsign().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        }

                    }
                    else {
                        if (options.matchCase) {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        } else {
                            if (options.allField) {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    if (!($(this).text().toLowerCase().replace(/\s+/g, ' ').indexOf(key[i]) >= 0)) $(this).addClass('notResult');
                                }
                            } else {
                                for (var i = 0; i < key.length && !$(this).hasClass('notResult') ; i++) {
                                    var found = false;
                                    $(this).find('.key').each(function () {
                                        if ($(this).text().toLowerCase().replace(/\s+/g, ' ').indexOf(key[i]) >= 0) {
                                            found = true;
                                        }
                                    });
                                    if (!found) {
                                        i = key.length;
                                    }
                                }
                                if (!found) {
                                    $(this).addClass('notResult');
                                }
                            }
                        }
                    }
                });

                // show/hide the appropriate regions
                selector.children().hide();
                selector.children(':not(.notResult)').show();
            }
        });
    }


})(jQuery);


String.prototype.toUnsign = function () {
    var str = this;

    //Replace the lower character
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    str = str.replace(/đ/g, "d");

    //Replace the lower character
    str = str.replace(/À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ/g, "A");
    str = str.replace(/È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ/g, "E");
    str = str.replace(/Ì|Í|Ị|Ỉ|Ĩ/g, "I");
    str = str.replace(/Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ/g, "O");
    str = str.replace(/Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ/g, "U");
    str = str.replace(/Ỳ|Ý|Ỵ|Ỷ|Ỹ/g, "Y");
    str = str.replace(/Đ/g, "D");

    return str;
}