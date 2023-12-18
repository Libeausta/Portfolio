window.addEventListener('DOMContentLoaded', () =>{
                let game = document.getElementById('puzzle-game');
                let result = game.querySelector('.puzzle-result');
                let source = game.querySelector('.puzzle-source');
                const width = 9;
                const height = 6;
                const size = 50;
                const imageUrl = 'image.jpg'
                result.style.gridTemplateColumns = `repeat(${width}, ${size}px)`;
                let tiles = [];
                for (let y = 0; y < height; y++){
                    tiles[y] = [];
                    for (let x = 0; x < width; x++){
                        let cell = document.createElement('div');
                        cell.className = 'puzzle-cell';
                        cell.x = x;
                        cell.y = y;
                        cell.style.width = `${size}px`;
                        cell.style.height = `${size}px`;
                        result.append(cell)

                        let tile = document.createElement('div');
                        tile.className = 'puzzle-item';
                        tile.x = x;
                        tile.y = y;
                        tile.style.backgroundImage = `url(${imageUrl})`;
                        tile.style.width = `${size}px`;
                        tile.style.height = `${size}px`;
                        tile.style.backgroundPosition = `${-x * size}px ${-y * size}px`;
                        cell.append(tile);
                        tiles[y].push(tile);
                    }
                }
                let leftPane = game.querySelector('.left-pane');
                let srcWidth = leftPane.offsetWidth;
                let srcHeight = leftPane.offsetHeight;
                for (let i = 0; i < 1000; i++){
                    let randX = Math.round(Math.random() * (width - 1));
                    let randY = Math.round(Math.random() * (height - 1));
                    let randTile = tiles[randY][randX];

                    let posLeft = Math.round(Math.random()*(srcWidth - size));
                    let posTop = Math.round(Math.random()*(srcHeight - size));

                    randTile.style.position = 'absolute';
                    randTile.style.left = `${posLeft}px`;
                    randTile.style.top = `${posTop}px`;
                    source.append(randTile);
                }

                source.addEventListener('click', e =>{
                    let target = e.target;
                    if (target.classList.contains('puzzle-item')){
                        e.preventDefault();
                        for (let tile of source.children){
                            tile.style.zIndex = 0;
                        }

                        target.style.zIndex = 10;

                        target.style.pointerEvents = 'none';

                        let lastX = e.clientX;
                        let lastY = e.clientY;

                        let checkMove = e =>{
                            let diffX = e.clientX - lastX;
                            let diffY = e.clientY - lastY;

                            target.style.top = `${target.offsetTop + diffY}px`;
                            target.style.left = `${target.offsetLeft + diffX}px`;

                            lastX = e.clientX;
                            lastY = e.clientY;
                        };

                        let checkUp = e =>{
                            document.removeEventListener('mousemove', checkMove);
                            document.removeEventListener('mouseup', checkUp);
                            result.removeEventListener('mouseup', checkOver);
                            target.style.pointerEvents = 'all';
                        }

                        document.addEventListener('mousemove', checkMove);
                        document.addEventListener('mouseup', checkUp);

                        let checkOver = e =>{
                            let t = e.target;
                            if (t.classList.contains('puzzle-cell')){
                                if (t.x === target.x && t.y === target.y){
                                    target.style.position = 'relative';
                                    target.style.top = 0;
                                    target.style.left = 0;
                                    t.append(target);
                                }
                            }
                        }

                        result.addEventListener('mouseup', checkOver);
                    }
                })
            });
