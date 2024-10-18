with import <nixpkgs> { };
with lib;
let
  list = ["a" "b" "a" "c" "d" "a"];
  intList = [ 1 2 3 ];
  countA = fold (el: c: if el == "a" then c + 1 else c) 0;
  mulB = fold (el: c: [(el * 2)] ++ c) [8];
in {
  example = fold (x: y: x + y) "z" ["a" "b" "c"]; #is "abcz"
  ex0 = countA list; #should be 3
  ex1 = mulB intList; #should be [ 2 4 6 8 ]
}
