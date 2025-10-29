# 🎓 EduQuiz Smart Contract  

EduQuiz is a simple and interactive **blockchain-based quiz platform** built with **Solidity**.  
It allows educators to create quiz questions and students to answer them directly on the blockchain — bringing **education** and **Web3** together in a transparent and fun way!  

---
<img width="1920" height="1080" alt="Screenshot 2025-10-29 135456" src="https://github.com/user-attachments/assets/fa02b5cb-8a06-4d5e-b950-e55d55c35f71" />


## 📘 Project Description  

EduQuiz demonstrates how blockchain can make learning **decentralized, transparent, and rewarding**.  
The contract allows a **quiz creator (teacher)** to add questions with correct answers, while **students (players)** can participate by submitting their responses.  
Each correct answer earns the student points that are securely stored on-chain.  

This project is ideal for beginners who want to learn:  
- How smart contracts work in Solidity  
- How to use structs, arrays, and mappings  
- Ownership control using modifiers  
- Deploying contracts on test networks like **Celo Sepolia**  

---

## 💡 What It Does  

- 🧑‍🏫 The **owner (teacher)** can create quiz questions.  
- 🧠 **Players (students)** can answer the questions directly on-chain.  
- 🏆 Automatic scoring system that rewards correct answers with points.  
- 🔍 Players can check their total scores anytime using `getMyScore()`.  

---

## ✨ Features  

✅ **Owner Access Control:** Only the quiz creator can add questions.  
✅ **Transparent Scoring:** Scores are publicly visible and verifiable on-chain.  
✅ **Immutable Records:** Once deployed, data can’t be altered — ensuring fairness.  
✅ **Beginner-Friendly:** Easy-to-understand logic and deployment steps.  
✅ **Fully Decentralized:** No central authority or external database.  

---

## 🔗 Deployed Smart Contract  

- **Network:** Celo Sepolia Testnet  
- **Deployed Address:** [`0xf1f691Ca80B54c8262D7bc5C1e1BC3969454eeFb`](https://celo-sepolia.blockscout.com/address/0xf1f691Ca80B54c8262D7bc5C1e1BC3969454eeFb)  

---

## 🧩 Smart Contract Code  

```solidity
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
