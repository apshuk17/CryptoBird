// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./interfaces/IERC165.sol";

contract ERC165 is IERC165 {
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor() {
        _registerInterface(bytes4(keccak256(abi.encodePacked('supportsInterface(bytes4)'))));
    }

    function supportsInterface(bytes4 interfaceID) external override view returns(bool) {
        return _supportedInterfaces[interfaceID];
    }

    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: Invalid Interface");
        _supportedInterfaces[interfaceId] = true;
    }
}