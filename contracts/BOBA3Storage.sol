//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;


contract BOBA3Storage {

    mapping(uint256 => string) public base;

    string public background = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAABlBMVEX////y0Nzt3y8gAAAAXUlEQVR4AQXBsQ3CMBAAwPvIEhai+DDBK1NQkk0yikWVLhmAjm2YhDG4E7zpHsy/K0P6fPsFcZjOtugi2HQ1JGcRBQvURnOD6gDYASQUJKAALUkA8XQ3vyaIgbX9AVHmCryyZMHkAAAAAElFTkSuQmCC";
    string public outline = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAdElEQVR4Ae2OAQaAQBREu2zn6iIBQbfpCJOwDFq005paMzzgf+9NIy7DhVU+b7stguVwyAvegJ5yVGA58670WNZbOIDv9BiWajRHgGiTFoQAHh7C0wPEQXg0yROQABps8gQkgAaD/HsBEO47hEhifajwr2Unok36vrgCTXoAAAAASUVORK5CYII=";
    string public bubbles = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAARElEQVR4AezBgQAAAACAoP2pF6kCAIBHIvifZmn4H58czR0Awvjk6OgYhEWEHUr/EKG/z+kc9JjxPVAhgrB0qIJRMAoAL9UhlcfLVsoAAAAASUVORK5CYII=";
    string public cream = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAABlBMVEUAAAD+++qtqtQFAAAAAXRSTlMAQObYZgAAAB1JREFUeAFjoAg8YDzAwPD/P5Cw/w/k8v9joDYAAF3wBquRIdO3AAAAAElFTkSuQmCC";

    constructor() {

        // Tea layer
        base[0] = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAABlBMVEUAAAD3z7SVgmCOAAAAAXRSTlMAQObYZgAAACpJREFUeAFjoAg8YDzAwPD/P5Co/9+AnbD/z4CdkP8HI/j/AAnmD1htAABc+hjENIBJ+AAAAABJRU5ErkJggg==";
        // Latte layer
        base[1] = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAABlBMVEUAAADFpYLixUfEAAAAAXRSTlMAQObYZgAAACpJREFUeAFjoAg8YDzAwPD/P5Co/9+AnbD/z4CdkP8HI/j/AAnmD1htAABc+hjENIBJ+AAAAABJRU5ErkJggg==";

    }

    function getBack() external view returns (string memory) {
        return background;
    }

    function getOutline() external view returns (string memory) {
        return outline;
    }

    function getBase(uint256 _index) external view returns (string memory) {
        return base[_index];
    }
}