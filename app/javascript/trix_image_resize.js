document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("trix-editor").forEach(editor => {
    let isResizing = false;
    let resizeDirection = null;
    let aspectRatio = 1;

    editor.addEventListener("mousemove", function (e) {
      const target = e.target;

      if (target.tagName === "IMG" && !isResizing) {
        const rect = target.getBoundingClientRect();
        const offset = 12; // エッジの感知領域を広げる

        // 各端でのカーソル判定と設定
        if (
          e.clientX >= rect.right - offset &&
          e.clientX <= rect.right + offset &&
          e.clientY >= rect.bottom - offset &&
          e.clientY <= rect.bottom + offset
        ) {
          target.style.cursor = "nwse-resize"; // 右下: 斜めリサイズ
          resizeDirection = "bottom-right";
          aspectRatio = target.clientWidth / target.clientHeight;
        } else if (
          e.clientX >= rect.left - offset &&
          e.clientX <= rect.left + offset &&
          e.clientY >= rect.top - offset &&
          e.clientY <= rect.top + offset
        ) {
          target.style.cursor = "nwse-resize"; // 左上: 斜めリサイズ
          resizeDirection = "top-left";
          aspectRatio = target.clientWidth / target.clientHeight;
        } else if (
          e.clientX >= rect.left - offset &&
          e.clientX <= rect.left + offset &&
          e.clientY >= rect.bottom - offset &&
          e.clientY <= rect.bottom + offset
        ) {
          target.style.cursor = "nesw-resize"; // 左下: 斜めリサイズ
          resizeDirection = "bottom-left";
          aspectRatio = target.clientWidth / target.clientHeight;
        } else if (
          e.clientX >= rect.right - offset &&
          e.clientX <= rect.right + offset &&
          e.clientY >= rect.top - offset &&
          e.clientY <= rect.top + offset
        ) {
          target.style.cursor = "nesw-resize"; // 右上: 斜めリサイズ
          resizeDirection = "top-right";
          aspectRatio = target.clientWidth / target.clientHeight;
        } else if (
          e.clientX >= rect.left - offset &&
          e.clientX <= rect.left + offset
        ) {
          target.style.cursor = "ew-resize"; // 左端: 水平方向リサイズ
          resizeDirection = "left";
        } else if (
          e.clientX >= rect.right - offset &&
          e.clientX <= rect.right + offset
        ) {
          target.style.cursor = "ew-resize"; // 右端: 水平方向リサイズ
          resizeDirection = "right";
        } else if (
          e.clientY >= rect.top - offset &&
          e.clientY <= rect.top + offset
        ) {
          target.style.cursor = "ns-resize"; // 上端: 垂直方向リサイズ
          resizeDirection = "top";
        } else if (
          e.clientY >= rect.bottom - offset &&
          e.clientY <= rect.bottom + offset
        ) {
          target.style.cursor = "ns-resize"; // 下端: 垂直方向リサイズ
          resizeDirection = "bottom";
        } else {
          target.style.cursor = "default"; // 通常のカーソル
          resizeDirection = null;
        }
      }
    });

    editor.addEventListener("mousedown", function (e) {
      const target = e.target;

      if (target.tagName === "IMG" && resizeDirection) {
        isResizing = true;
        const startX = e.clientX;
        const startY = e.clientY;
        const startWidth = target.clientWidth;
        const startHeight = target.clientHeight;

        document.body.style.cursor = target.style.cursor; // カーソルを保持

        function onMouseMove(event) {
          if (isResizing) {
            let newWidth = startWidth;
            let newHeight = startHeight;

            const deltaX = event.clientX - startX;
            const deltaY = event.clientY - startY;

            if (resizeDirection === "right" || resizeDirection === "bottom-right") {
              newWidth = startWidth + deltaX;
              newHeight = newWidth / aspectRatio; // 比率を保持
            } else if (resizeDirection === "bottom") {
              newHeight = startHeight + deltaY;
              newWidth = newHeight * aspectRatio; // 比率を保持
            } else if (resizeDirection === "left") {
              newWidth = startWidth - deltaX;
              newHeight = newWidth / aspectRatio; // 左リサイズでも比率を保持
            } else if (resizeDirection === "top") {
              newHeight = startHeight - deltaY;
              newWidth = newHeight * aspectRatio; // 上リサイズでも比率を保持
            } else if (resizeDirection === "top-left" || resizeDirection === "top-right" || resizeDirection === "bottom-left") {
              newWidth = startWidth - deltaX;
              newHeight = newWidth / aspectRatio; // 比率を保持
            }

            // サイズが極端に小さくならないように制限
            if (newWidth > 50 && newHeight > 50) {
              target.style.width = newWidth + "px";
              target.style.height = newHeight + "px";
            }

            event.preventDefault(); // マウスのデフォルト動作を無効化
          }
        }

        function onMouseUp() {
          if (isResizing) {
            isResizing = false;
            resizeDirection = null;
            document.body.style.cursor = "default"; // カーソルを元に戻す
            document.removeEventListener("mousemove", onMouseMove);
            document.removeEventListener("mouseup", onMouseUp);
          }
        }

        document.addEventListener("mousemove", onMouseMove);
        document.addEventListener("mouseup", onMouseUp);
        e.preventDefault(); // 画像のデフォルトのドラッグ動作を無効化
      }
    });
  });
});
