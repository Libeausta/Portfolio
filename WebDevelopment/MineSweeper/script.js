document.addEventListener('DOMContentLoaded', () => {
    const grid = document.querySelector('.mw-grid')
    const minesLeft = document.querySelector('#mines-left');
    const result = document.querySelector('#mw-result');
    const time = document.querySelector('#time');
    const emotion = document.querySelector('.mw-header--emotion');
    let width = 12;
    let bombCount = 15;
    let flags = 0;
    let cellNew = [];
    let timeCount = 0;
    let intervalRef = null;
    let isGameOver = false;
    
    function createBoard() {
      const bombArray = Array(bombCount).fill('bomb');
      const emptyArray = Array(width * width - bombCount).fill('valid');
      const gameArray = emptyArray.concat(bombArray);
      const shuffledArray = gameArray.sort(() => Math.random() - 0.5);
      emotion.innerHTML = '🙂';
      minesLeft.innerHTML = bombCount;
  
      for (let i = 0; i < width * width; i++) {
        const cell = document.createElement('div');
        cell.setAttribute('id', i);
        cell.classList.add(shuffledArray[i]);
        grid.appendChild(cell);
        cellNew.push(cell);
  
        cell.addEventListener('click', function(e) {
          if (isGameOver) { return }
          click(cell);
        });

        cell.oncontextmenu = function(e) {
          e.preventDefault();
          addFlag(cell);
        }
      }
  
      for (let i = 0; i < cellNew.length; i++) {
        let total = 0;
        const isLeftEdge = (i % width === 0);
        const isRightEdge = (i % width === width - 1);
  
        if (cellNew[i].classList.contains('valid')) {
          if (i > 0 && !isLeftEdge && cellNew[i - 1].classList.contains('bomb')) { total++ };
          if (i > 11 && !isRightEdge && cellNew[i + 1 - width].classList.contains('bomb')) { total++ };
          if (i > 12 && cellNew[i - width].classList.contains('bomb')) { total++ };
          if (i > 13 && !isLeftEdge && cellNew[i - 1 - width].classList.contains('bomb')) { total++ };
          if (i < 142 && !isRightEdge && cellNew[i + 1].classList.contains('bomb')) { total++ };
          if (i < 132 && !isLeftEdge && cellNew[i - 1 + width].classList.contains('bomb')) { total++ };
          if (i < 130 && !isRightEdge && cellNew[i + 1 + width].classList.contains('bomb')) { total++ };
          if (i < 131 && cellNew[i + width].classList.contains('bomb')) { total++ };
          cellNew[i].setAttribute('data', total);
        }
      }
    }
    createBoard();

    let cellNavigate = [...document.querySelectorAll('.mw-grid div')];
    let cellIndex = 0;
    const toggleTile = (i) => cellNavigate[i].classList.toggle('active');
    const cellDirection = { ArrowLeft: 143, ArrowRight: 1, ArrowUp: 132, ArrowDown: 12 };
    toggleTile(cellIndex);
    document.addEventListener('keydown', function(e) {
      if (cellDirection.hasOwnProperty(e.key)) {
        toggleTile(cellIndex);
        cellIndex = (cellIndex + cellDirection[e.key]) % 144;
        toggleTile(cellIndex);
      }
    });

    function addFlag(cell) {
      if (isGameOver) { return }
      if (!cell.classList.contains('checked') && (flags < bombCount)) {
        if (!cell.classList.contains('flag')) {
          cell.classList.add('flag');
          cell.innerHTML = '🚩';
          flags++;
          minesLeft.innerHTML = bombCount - flags;
          checkForWin();
        } else { 
          cell.classList.remove('flag');
          cell.innerHTML = '';
          flags--;
          minesLeft.innerHTML = bombCount - flags;
        } 
      }
    }
    
    function click(cell) {
      let currentPos = cell.id;
      if (isGameOver) { return };
      if (cell.classList.contains('checked') || cell.classList.contains('flag')) { return };
      if (cell.classList.contains('bomb')) {
        gameOver();
      } else {
        let total = cell.getAttribute('data');
        if (total != 0) {
          cell.classList.add('checked');
          if (total == 1) { cell.classList.add('one') };
          if (total == 2) { cell.classList.add('two') };
          if (total == 3) { cell.classList.add('three') };
          if (total == 4) { cell.classList.add('four') };
          if (total == 5) { cell.classList.add('five') };
          cell.innerHTML = total;
          return
        }
        checkcell(cell, currentPos);
      }
      cell.classList.add('checked');
    }
  
    function checkcell(cell, currentPos) {
      const isLeftEdge = (currentPos % width === 0)
      const isRightEdge = (currentPos % width === width - 1)
  
      setTimeout(() => {
        if (currentPos > 0 && !isLeftEdge) {
          const newId = cellNew[parseInt(currentPos) - 1].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
        if (currentPos > 11 && !isRightEdge) {
          const newId = cellNew[parseInt(currentPos) + 1 - width].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
        if (currentPos >= 12) {
          const newId = cellNew[parseInt(currentPos - width)].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
        if (currentPos >= 13 && !isLeftEdge) {
          const newId = cellNew[parseInt(currentPos) - 1 - width].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
        if (currentPos <= 142 && !isRightEdge) {
          const newId = cellNew[parseInt(currentPos) + 1].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
        if (currentPos < 132 && !isLeftEdge) {
          const newId = cellNew[parseInt(currentPos) - 1 + width].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
        if (currentPos <= 130 && !isRightEdge) {
          const newId = cellNew[parseInt(currentPos) + 1 + width].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
        if (currentPos <= 131) {
          const newId = cellNew[parseInt(currentPos) + width].id;
          const newcell = document.getElementById(newId);
          click(newcell);
        }
      }, 10);
    }

    let startTime = function() {
      intervalRef = setInterval(() => {
        timeCount += 10;
        let s = Math.floor((timeCount / 1000));
        time.innerHTML = s;
      }, 10);
      removeEventListener('click', startTime);
    }
    window.addEventListener('click', startTime);
  
    function gameOver(cell) {
      clearInterval(intervalRef);
      time.innerHTML = '✖';
      emotion.innerHTML = '😵';
      result.innerHTML = 'К сожалению, вы проиграли. Игра окончена!';
      isGameOver = true;

      cellNew.forEach(cell => {
        if (cell.classList.contains('bomb')) {
          cell.innerHTML = '💣';
        }
      });
    }
  
    function checkForWin() {
      let matches = 0;
      for (let i = 0; i < cellNew.length; i++) {
        if (cellNew[i].classList.contains('flag') && cellNew[i].classList.contains('bomb')) {
          matches++;
        }
        if (matches === bombCount) {
          clearInterval(intervalRef);
          time.innerHTML = '🏆'
          emotion.innerHTML = '😎';
          result.innerHTML = 'Поздравляем с победой, вам удалось найти все бомбы!';
          isGameOver = true;
        }
      }
    }

    emotion.addEventListener('click', function(e) {
      location.reload();
    });






    let posX = 0;
    let posY = 0;
    let currentCell = bombCells[posY][posX];

    const blurFocus = () => {
      mw.querySelector('.active')?.classList.remove('active');
    };

    const setFocus = () => {
        blurFocus();
        currentCell.classList.add('active');
    };

    const setCurrent = () => {
        if (posY < 0) posY = 0;
        if (posX < 0) posX = 0;
        if (posY > height - 1) posY = height - 1;
        if (posX > width - 1) posX = width - 1;
        currentCell = bombCells[posY][posX];
        setFocus();
    };

    const moveRight = () => { posX++; setCurrent(); };
    const moveDown = () => { posY++; setCurrent(); };
    const moveUp = () => { posY--; setCurrent(); };
    const moveLeft = () => { posX--; setCurrent(); };
    
    document.addEventListener('keydown', e => {
        switch (e.code) {
            case 'ArrowUp': moveUp(); break;
            case 'ArrowDown': moveDown(); break;
            case 'ArrowLeft': moveLeft(); break;
            case 'ArrowRight': moveRight(); break;
            case 'Enter':
            case 'Space':
                if (!gameStarted) {
                    startGame(currentCell);
                }
                if (e.ctrlKey || e.metaKey) {
                    markCell(currentCell); break;
                } else {
                    openCell(currentCell); break;
                }
        }
    });

  });