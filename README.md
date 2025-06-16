# Econ 106 Website

This is the Quarto-powered website for **Econ 106: Data Analysis in Economics** at UC Riverside. It includes the syllabus, lecture notes, R scripts, and research project materials, all hosted on GitHub Pages.

---

## ✅ How to Update and Publish the Website (No Terminal Required)

Follow these steps whenever you want to make changes to the site or add new lectures:

---

### 🔧 Step 1: Open the Project in RStudio or Quarto Desktop

- Open the `Econ106F24/` folder on your computer
- Open the project in **RStudio** (or **Quarto Desktop**)
- In RStudio, make sure the **working directory** is set to the project root:
  - Click **Session > Set Working Directory > To Project Directory**
- Files you can edit:
  - `index.qmd` → homepage
  - `lectures.qmd` → summary of all lectures
  - `project.qmd` → research milestones
  - `lectures/lectureX.qmd` → individual lecture pages

---

### 🖼️ Step 2: Edit or Add Content

- Add new `.qmd` files in the `/lectures/` folder for each lecture
- Copy lecture slides (`.pdf`, `.pptx`) to `/lectures/`
- Save any R scripts to `/lecture-scripts/`

---

### 🌐 Step 3: Render the Website

In RStudio or Quarto Desktop:

- Click the **"Render Website"** button (from the Build pane)
- This creates or updates the `/docs/` folder with the `.html` files needed for the website

> 📂 All public-facing HTML files must appear in the `/docs/` folder to be published on GitHub Pages.

---

### 💻 Step 4: Use GitHub Desktop to Commit and Push

1. Open **GitHub Desktop**
2. Make sure you're on the `main` branch
3. You’ll see file changes in `/docs/` and possibly `/lectures/` or `/lecture-scripts/`
4. Write a clear commit message like:  
   `"Added Lecture 6 HTML and PDF"`
5. Click **“Commit to main”**
6. Click **“Push origin”**

> 🔁 Your website will automatically update after pushing — GitHub Pages uses the `docs/` folder from the `main` branch.

---

## 📁 Folder Structure Explained

```
Econ106F24/
├── index.qmd                # Home page with syllabus
├── lectures.qmd             # Lecture summaries and links
├── project.qmd              # Final project overview and milestones
├── _quarto.yml              # Site configuration
├── Econ 106 Syllabus  Fall 2024.pdf  # Embedded on homepage
│
├── /lectures/               # PDFs, PPTs, and individual lecture qmd
│   ├── Econ 106 Lecture 1.pdf
│   ├── Econ 106 Lecture 1.pptx
│   ├── lecture1.qmd
│   └── ...
│
├── /lecture-scripts/        # R scripts for each lecture
│   ├── Lecture 1.R
│   └── ...
│
├── /Project Milestones/     # PDFs and R files for research project
│   ├── Research Milestone 1.pdf
│   ├── Milestone 1.R
│   └── ...
│
├── /docs/                   # Final rendered site (automatically created)
│   ├── index.html
│   ├── lectures.html
│   ├── html-lectures/
│   └── ...
```

---

## 📝 Recap

- Always set your working directory to the **project root**
- Use **RStudio or Quarto Desktop** to render
- Use **GitHub Desktop** to commit and push
- Site automatically updates via GitHub Pages from `/docs/`
