program WormHunter;                              { wormhunter.pas }
uses crt;
const
    SpeedRate = 80;

procedure GetKey(var code: integer);
var
    c: char;
begin
    c := ReadKey;
    if c = #0 then
    begin
        c := ReadKey;
        code := -ord(c);
    end
    else
    begin
        code := ord(c);
    end
end;

type
    snake = record
        tailX, tailY, headX, headY, dx, dy, len, elem: integer;
        body: array [1..19200] of array [0..1] of integer
    end;
    
    food = record
        showX, showY, count: integer;
        hasEaten: boolean
    end;

procedure GameScore(count: integer);
var 
    i: integer;
begin
    GotoXY(3, 1);
    write('<<<WormHunter 2024>>>   Score: ', count);
    for i := 0 to ScreenWidth do
    begin
        GotoXY(i, 2);
        write('_')
    end;
    GotoXY(1, 1);
end;

procedure DrawFood(var f: food);
begin
    if f.hasEaten then
    begin    
        f.showX := random(ScreenWidth - 1);
        f.showY := 3 + random(ScreenHeight - 2);
        GotoXY(f.showX, f.showY);
        write('~');
        GotoXY(1, 1);    
        f.hasEaten := False
    end;
end;


procedure ShowHead(var s: snake);
begin
    GotoXY(s.headX, s.headY);
    write('o');
    GotoXY(1, 1)
end;

procedure HideTail(var s: snake);
begin
    GotoXY(s.tailX, s.tailY);
    write(' ');
    GotoXY(1, 1)
end;

procedure MoveSnake(var s: snake; var f: food; var gameOver: boolean);
var
    i: integer;
begin
    if s.elem <> s.len + 1 then                 { next element pointer from coordinates array }
        s.elem := s.elem + 1
    else
        s.elem := 1;

    s.tailX := s.body[s.elem][0];               { set Tail as last changed variable from array and clear it from the screen }
    s.tailY := s.body[s.elem][1];
    HideTail(s);    
    
    s.headX := s.headX + s.dx;                  { set HeadX and HeadY for new coordinate and write it in place of disappeared Tail }
    if s.headX > ScreenWidth - 1 then
        s.headX := 1
    else
    if s.headX < 1 then
        s.headX := ScreenWidth - 1;
    s.body[s.elem][0] := s.headX;

    s.headY := s.headY + s.dy;
    if s.headY > ScreenHeight then
        s.headY := 3
    else
    if s.headY < 3 then
        s.headY := ScreenHeight;
    s.body[s.elem][1] := s.headY;    
    ShowHead(s);                                { draw new position of head }

    for i := 1 to s.len do
    begin
        if (i <> s.elem) and (s.body[i][0] = s.headX) and (s.body[i][1] = s.headY) then
        begin
            gameOver := True;
            exit
        end;
    end;

    if (s.body[s.elem][0] = f.showX) and (s.body[s.elem][1] = f.showY) then
    begin
        f.hasEaten := True;
        f.count := f.count + 1;
        s.len := s.len + 1;
    end;    
    DrawFood(f);
end;

procedure SetDirection(var s: snake; dx, dy: integer);
begin
    s.dx := dx;
    s.dy := dy;
end;

procedure NewGame(var gameOver: boolean);
var
    s: snake;
    f: food;
    ctrl: integer;
    canChangeDirection: boolean;

begin
    clrscr;
    randomize;
    gameOver := False;
    canChangeDirection := True;
        
    s.len := 5;                                             { initialize snake}
    s.elem := 1;
    s.headX := (ScreenWidth div 2) + 2;
    s.headY := ScreenHeight div 2 + 1;
    s.dx := 1;
    s.dy := 0;
          
    f.hasEaten := True;                                     { initialize food }
    f.count := 0;
    DrawFood(f);
        
    while not gameOver do                                   { standard game cycle }
    begin
        if not KeyPressed then
        begin
            GameScore(f.count);
            MoveSnake(s, f, gameOver);                            
            canChangeDirection := True;
            delay(SpeedRate);
            continue;
        end;
        GetKey(ctrl);
        if canChangeDirection then
        begin
            case ctrl of
                -75: if s.dx = 0 then 
                begin
                    SetDirection(s, -1, 0);
                    canChangeDirection := False;
                end;
                -77: if s.dx = 0 then
                begin
                    SetDirection(s, 1, 0); 
                    canChangeDirection := False;
                end;
                -72: if s.dy = 0 then 
                begin
                    SetDirection(s, 0, -1); 
                    canChangeDirection := False;
                end;
                -80: if s.dy = 0 then 
                begin
                    SetDirection(s, 0, 1); 
                    canChangeDirection := False;
                end;
                27: 
                begin
                    gameOver := True;
                    clrscr;
                    exit;
                end;
            end
        end;
    end;
    GotoXY(ScreenWidth div 2 - 9, ScreenHeight div 2 + 1);
    write('Game over, score: ', f.count);
    GotoXY(1, 1);
    delay(2000);
    clrscr;
end;

procedure DrawMenu(var choose: integer);
begin
    GotoXY(ScreenWidth div 2 - 8, ScreenHeight div 2 - 4);
    write('  Start');
    GotoXY(ScreenWidth div 2 - 8, ScreenHeight div 2);
    write('  Choose skin');
    GotoXY(ScreenWidth div 2 - 8, ScreenHeight div 2 + 4);
    write('  Exit');
    case choose of
        1: GotoXY(ScreenWidth div 2 - 8, ScreenHeight div 2 - 4);                   
        2: GotoXY(ScreenWidth div 2 - 8, ScreenHeight div 2);
        3: GotoXY(ScreenWidth div 2 - 8, ScreenHeight div 2 + 4);
    end;
    write('>');
    GotoXY(1, 1);
end;


procedure MainMenu;
var
    ctrl, choose: integer;
    gameOver: boolean;
begin
    clrscr;
    choose := 1;
    gameOver := False;
    while True do
    begin
        if not KeyPressed then
        begin
            DrawMenu(choose);
            delay(100);
            continue;
        end;
        GetKey(ctrl);
        case ctrl of
            -72:
            begin
                choose := choose - 1;
                if choose < 1 then choose := 1;
            end;
            -80:
            begin
                choose := choose + 1;
                if choose > 3 then choose := 3;
            end;
            13:
            begin
                case choose of
                    1: 
                    begin
                        write('Starting new game...');
                        delay(1000);
                        NewGame(gameOver);
                        if gameOver then clrscr;
                    end;
                    2: continue;
                    3: break;
                end;
            end;
            27: break
        end
    end;
end;

begin
    TextColor(White);
    TextBackground(LightCyan);                                                   { main menu cycle }
    
    MainMenu;
    
    clrscr;
    write(#27'[0m');
end.


{ Bugs:
1. Make food not to appear just in the middle of snake body 
2. Prevent to going backward after quickclicking to the any side (and dying) }

{ Possible features:
1. Add information about current screen size on the bottom
2. Add changeable skins in menu
3. And add my name on the bottom! }
