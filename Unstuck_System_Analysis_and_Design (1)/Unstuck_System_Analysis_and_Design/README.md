# UNSTUCK – Software System Analysis & Design Specification
## Digital Egypt Pioneers Initiative (DEPI) | Ministry of Communications and Information Technology (MCIT)
### Track: Software Engineering & Full-Stack AI Development
### Author / Engineer: Aya Elsayed | Document Standard: ISO/IEC/IEEE 29148:2018

---

## 🌟 Executive Overview & Deliverable Suite

This directory contains the formal, end-to-end **System Analysis & Design (Section 4)** deliverables engineered directly from the production codebase of **UNSTUCK** located at:
`C:\Users\Aya_Elsayed\Downloads\Unstuck_UI_Updated (1)`

The documentation has been crafted to the highest international software engineering standards, integrating rigorous UML diagrams, relational data models, behavioral state charts, OpenAPI contracts, and verified test matrices.

---

## 🚀 How to Review, Present, and Submit

### 1. Interactive Visual Reader (Recommended for Reviewers & PDF Generation)
👉 **Double-click `VIEWER.html`**
- Opens in any modern browser (Chrome, Edge, Firefox, Safari).
- Renders all **Mermaid UML and Architecture Diagrams** with vector-sharp visual rendering.
- Features an integrated **Reading Progress Bar**, institutional header, and responsive layout.
- Includes a top action button: **"🖨️ Print / Save as PDF"** pre-configured with print stylesheets to output an executive, submission-ready PDF without sidebars or UI clutter.

### 2. Consolidated Academic Report (For Microsoft Word / Markdown)
👉 **Open `FULL_SYSTEM_ANALYSIS_AND_DESIGN.md`**
- A complete, unified document containing all 6 chapters in exact rubric order.
- Ready to be directly imported into Microsoft Word, Obsidian, or VS Code with clean formatting and tables.

---

## 📁 Structured Directory & File Inventory

```text
Unstuck_System_Analysis_and_Design/
│
├── 🌐 VIEWER.html                                    # Full Interactive Report with Rendered Diagrams & 1-Click PDF Print
├── 📄 FULL_SYSTEM_ANALYSIS_AND_DESIGN.md            # Master Consolidated Document (All 6 sections ready for MS Word / PDF)
├── 📖 README.md                                     # Submission & Directory Guide
│
├── 📁 01_Problem_Statement_and_Objectives/
│   ├── 1.1_Problem_Statement_and_Project_Goals.md   # Problem statement, proposed solution, and objectives
│   ├── 1.2_Use_Case_Diagram_and_Descriptions.md     # UML Use Case Diagram, actors, and detailed specs (UC-01 to UC-07)
│   ├── 1.3_Functional_and_NonFunctional_Requirements.md # Complete requirements with MoSCoW prioritization
│   └── 1.4_Software_Architecture.md                 # Decoupled multi-tier system architecture
│
├── 📁 02_Database_Design_and_Data_Modeling/
│   ├── 2.1_ER_Diagram.md                            # Entity-Relationship Diagram (ERD) with cardinality
│   ├── 2.2_Logical_and_Physical_Schema.md           # Physical data dictionary, indexes, and 3NF normalization
│   └── 2.3_Database_DDL_Scripts.sql                # Clean PostgreSQL 16 DDL script with UPSERT statements
│
├── 📁 03_Data_Flow_and_System_Behavior/
│   ├── 3.1_Data_Flow_Diagram_DFD.md                 # DFD Context (Level 0) & Level 1 Decomposition
│   ├── 3.2_Sequence_Diagrams.md                     # Sequence diagrams for Auth/OTP, Scraper, and AI Engine
│   ├── 3.3_Activity_Diagrams.md                     # Workflow activity diagrams for user and crawler pipelines
│   ├── 3.4_State_Diagrams.md                        # State machines for User, OTP token, and Project lifecycles
│   └── 3.5_Class_Diagram.md                         # Object-Oriented Domain and Service Class Diagram
│
├── 📁 04_UI_UX_Design_and_Prototyping/
│   ├── 4.1_Wireframes_and_Screen_Mockups.md         # Wireframe layouts for all 6 core application views
│   └── 4.2_UI_UX_Guidelines_and_Design_System.md  # Official Pantone color palette and WCAG 2.1 AA accessibility
│
├── 📁 05_System_Deployment_and_Integration/
│   ├── 5.1_Technology_Stack_Specification.md        # Complete matrix (React 18, FastAPI, Scrapy, PostgreSQL 16)
│   ├── 5.2_Deployment_Diagram.md                    # Physical and Docker container deployment topology
│   └── 5.3_Component_Diagram.md                     # High-level components and interface definitions
│
└── 📁 06_Additional_Deliverables/
    ├── 6.1_REST_API_Documentation.md                # RESTful API specifications with JSON request/response schemas
    ├── 6.2_Testing_and_Validation_Plan.md           # Test cases (TC-01 to TC-13) based on test_suite.py (100% Pass)
    └── 6.3_Deployment_Strategy_and_DevOps.md        # CI/CD pipeline, Docker containerization, and disaster recovery
```
