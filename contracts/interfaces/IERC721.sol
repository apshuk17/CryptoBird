// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

interface IERC721 {
    event Transfer(address indexed _from, address indexed _to, uint indexed _tokenId);

    event Approval(address indexed _owner, address indexed _approved, uint indexed _tokenId);

    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint _tokenId) external view returns (address);

    function transferFrom(address _from, address _to, uint _tokenId) external;

    function approve(address _approved, uint _tokenId) external;

    // event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    // function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external payable;

    // function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

    // function setApprovalForAll(address _operator, bool _approved) external;

    // function getApproved(uint256 _tokenId) external view returns (address);

    // function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}