// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EduQuiz {
    // Owner (creator of the quiz)
    address public owner;

    // Each question structure
    struct Question {
        string question;
        string correctAnswer;
    }

    // List of questions
    Question[] public questions;

    // Track player scores
    mapping(address => uint) public scores;

    // Modifier to restrict functions to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the quiz owner!");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Add a new question (only owner can do this)
    function addQuestion(string memory _question, string memory _correctAnswer) public onlyOwner {
        questions.push(Question(_question, _correctAnswer));
    }

    // Total number of questions
    function getQuestionCount() public view returns (uint) {
        return questions.length;
    }

    // Get question text by index
    function getQuestion(uint index) public view returns (string memory) {
        require(index < questions.length, "Invalid question index");
        return questions[index].question;
    }

    // Student submits an answer
    function answerQuestion(uint index, string memory _answer) public {
        require(index < questions.length, "Invalid question index");

        // Compare strings (keccak256 hash)
        if (keccak256(abi.encodePacked(_answer)) == keccak256(abi.encodePacked(questions[index].correctAnswer))) {
            scores[msg.sender] += 1; // Give 1 point for correct answer
        }
    }

    // View your score
    function getMyScore() public view returns (uint) {
        return scores[msg.sender];
    }
}
