$(document).on("turbolinks:load",function(){
  
  // プレビューを出す
  function imagePreview(blob,num) {
    let html = 
    `<div class="item-image" data-index=${num}>
      <img class="item-image__box" src="${blob}">
      <div class="item-image__footer">
        <label class="item-image__footer__edit", for="item_images_attributes_${num}_src">
          編集
        </label>
        <div class="item-image__footer__destroy">
          削除
        </div>
      </div>
    </div>`

    // $(".itembox__place").append(html)
    $(html).insertBefore(".itembox__place__name") // 何(html)を、どこの前へ(今回はグレーの箱の前へ)持っていくかが、insertBefore
  }
  // file_fieldを追加する
  function appendFileField(num) {
    let html = `<input data-file-field-id="${num + 1}" type="file" name="item[images_attributes][${num + 1}][src]" id="item_images_attributes_${num + 1}_src">`
    $("#file-field-area").append(html)
  }
  // labelの向き先を変える
  function changeLabelFor(num) {
    $(".itembox__place__name").attr("for", `item_images_attributes_${num + 1}_src`)
  }


  $(document).on("change",`input[type="file"]`,function(e){
    // num: 画面にある最後のtype="file"の要素
    let num = $(`input[type="file"]`).last().data("file-field-id") // ビューでは、file_field_idをアンダーバーで定義したが、実際に画面で確認すると、file-field-idを、ハイフンに変わっている。
    let index = $(this).data("file-field-id");
    let file = e.target.files[0];
    let blob = window.URL.createObjectURL(file);

    if ($(`.item-image[data-index="${index}"]`)[0]){
      const preview_image = $(`.item-image[data-index="${index}"]`).children("img");
      preview_image.attr("src", blob);
      return false;
    }

    imagePreview(blob,num)
    appendFileField(num)
    changeLabelFor(num)

  })

  $(document).on("click",".item-image__footer__destroy",function(){
    // console.log("ok")
    const index = $(this).parents(".item-image").data("index");
    $(this).parents(".item-image").remove();
    $(`#item_images_attributes_${index}__destroy`).prop("checked", true);
    $(`#item_images_attributes_${index}_src`).remove();
  })


})