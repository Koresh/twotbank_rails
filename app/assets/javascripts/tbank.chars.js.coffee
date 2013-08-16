window.TbWidgets  = window.TbWidgets or {}

class TbWidgets.CharsAnimate
  
  constructor: (@container, @options) ->

    @selecter       = $ "#chars-selecter"
    @char_item      = @container.find ".char-item"
    @selecter_title = $ "#selecter-title"
    @current        = @container.find(".dropdown").find(".current")

    @selecter.on "change", (e) =>

      $this = @selecter.find("option:selected")

      value = $this.val()
      title = $this.data "title"

      @select value, title


  select: (index, title) ->

    @char_item.addClass "hide"
    $("#char-item-#{index}").removeClass "hide"
    @selecter_title.text title
    @current.text("что–нибудь другое")



$ ->
  new TbWidgets.CharsAnimate $("#chars-block")

# var objMyRules = {
#     init: function() {
#         this.initMyRules();
#     },
#     initMyRules: function() {
#         $(document).ready(function() {
#             $('#char').change(function() {
#                 var option = $('#char option:selected'),
#                     title = option.attr('data-title'),
#                     id = option.attr('data-id'),
#                     content = option.attr('data-content'),
#                     url = document.location.href;

#                 $('.cat span.character').html(title);

#                 if (id) {
#                     $('.cat .id-char').addClass('hide');
#                     $('.cat .id-char' + id).removeClass('hide');
#                 }

#                 $.cookie('char_id', id, { expires: 1, path: url });
#                 $('.cat .txt2 div.CFEList div.CFEselectListItem:first').trigger('click');
#             });
#         });
#     }
# };

# $(function() {
#     objMyRules.init();
# });