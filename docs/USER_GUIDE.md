# Mukai-Translate — User Guide

A step-by-step reference for all features and settings.

---

## Table of Contents

1. [Getting Started](#1-getting-started)
2. [Importing Files](#2-importing-files)
3. [Main Interface Overview](#3-main-interface-overview)
4. [Processing Modes](#4-processing-modes)
5. [Language Selection](#5-language-selection)
6. [Translation Settings](#6-translation-settings)
7. [OCR Settings](#7-ocr-settings)
8. [Text Detection Settings](#8-text-detection-settings)
9. [Inpainting (Text Removal) Settings](#9-inpainting-text-removal-settings)
10. [Text Rendering & Fonts](#10-text-rendering--fonts)
11. [Canvas Tools](#11-canvas-tools)
12. [Page / Image Management](#12-page--image-management)
13. [Search & Replace](#13-search--replace)
14. [Webtoon Mode](#14-webtoon-mode)
15. [Project Management](#15-project-management)
16. [Auto-Save](#16-auto-save)
17. [Account & Credits](#17-account--credits)
18. [Application Settings](#18-application-settings)
19. [Export](#19-export)
20. [Keyboard Shortcuts](#20-keyboard-shortcuts)
21. [Workflows](#21-workflows)
22. [Error Handling](#22-error-handling)

---

## 1. Getting Started

Launch Mukai-Translate to reach the **Home Screen**.

| Element | Description |
|---|---|
| **New Project** | Opens a file browser or drag-and-drop area to start a new translation project |
| **Recent Projects** | Lists recently opened projects for quick access |
| **Pin / Unpin** | Pin a project to keep it at the top of the recent list |
| **Remove from list** | Removes a project entry without deleting the file |
| **Clear all recent** | Wipes the entire recent projects list |

---

## 2. Importing Files

Drag files onto the home screen or use the file browser. Supported formats:

| Category | Formats |
|---|---|
| Images | PNG, JPG, JPEG, WebP, BMP, PSD |
| Documents | PDF, EPUB |
| Archives | ZIP, RAR, 7Z, TAR |
| Comic archives | CBZ, CBR, CB7, CBT |

All pages inside PDFs, EPUBs, and archives are automatically extracted and added to the page list.

---

## 3. Main Interface Overview

```
┌─ Title Bar ─────────────────────────────────────────────────┐
│  [Project name] [*]   Auto-Save ◉   Undo  Redo   — □ ✕     │
├─ Toolbar ───────────────────────────────────────────────────┤
│  Detect │ OCR │ Translate │ Load Seg │ Inpaint │ Render     │
│  [Source lang ▾] → [Target lang ▾]  [Set All]  [Translate] │
├─ Page List ──┬─ Canvas ────────────────┬─ Settings Panel ───┤
│  Thumbnails  │  Image viewer           │  Text / Font opts  │
│  (sidebar)   │  with overlaid boxes    │  API keys, etc.    │
└──────────────┴─────────────────────────┴────────────────────┘
```

### Title Bar

- **Project name** — displays the current file name; `[*]` means there are unsaved changes.
- **Auto-Save toggle** — enable/disable periodic automatic saving.
- **Undo / Redo** — step backwards or forwards through the edit history.

### Toolbar Steps (Manual mode)

| Button | Action |
|---|---|
| **Block Detect** | Run the detector to find speech bubbles and text regions |
| **OCR** | Extract text from detected regions |
| **Translate** | Translate the OCR'd text with the selected engine |
| **Load Segmentation** | Reload/adjust bounding box boundaries before OCR |
| **Inpaint & Set** | Remove original text from the image |
| **Render** | Place the translated text back into the cleaned image |

### Bottom Toolbar (Automatic mode)

| Control | Description |
|---|---|
| **Translate** button | Start the full automatic pipeline for all (non-skipped) pages |
| **Cancel** button | Abort the current batch run |
| **Progress bar** | Shows current image name and step |
| **Batch Report** | View the results of the last batch run (skipped pages, errors) |

---

## 4. Processing Modes

Switch modes with the **Mode toggle** in the toolbar.

### Automatic Mode

Runs the complete pipeline (Detect → OCR → Translate → Inpaint → Render) on all pages in sequence. Best for processing large volumes.

- The five individual step buttons are **disabled**.
- The **Translate** batch button is **enabled**.
- Configure all settings before starting; they apply to every page.

### Manual Mode (MTPE)

Run each step individually on the current page. Best for quality control and corrections.

- The five individual step buttons are **enabled**.
- The **Translate** batch button is **disabled**.
- Full undo/redo is available per image.

---

## 5. Language Selection

| Control | Description |
|---|---|
| **Source Language** | The original language of the comic |
| **Target Language** | The language to translate into |
| **Set All** | Apply the current source/target pair to every page at once |

### Supported Languages

English, Korean, French, Simplified Chinese, Russian, Japanese, German, Spanish, Italian, Turkish, Polish, Portuguese, Brazilian Portuguese, Thai, Vietnamese, Indonesian, Hungarian, Finnish, Arabic, Hebrew, Czech, Croatian, Persian, Romanian, Mongolian, and more.

---

## 6. Translation Settings

Open **Settings → Translation**.

### Translator Selection

| Engine | Type | Notes |
|---|---|---|
| **Gemini 2.5 Flash** | LLM (Google) | Fast, good quality |
| **GPT-4.1** | LLM (OpenAI) | High quality |
| **GPT-4.1 mini** | LLM (OpenAI) | Faster, cheaper |
| **Claude Sonnet 4.6** | LLM (Anthropic) | Balanced quality/speed |
| **Claude Haiku 4.5** | LLM (Anthropic) | Fastest Anthropic option |
| **Deepseek-v3** | LLM | Good multilingual support |
| **Grok-3** | LLM (xAI) | High quality |
| **Grok-3 Mini** | LLM (xAI) | Faster Grok option |
| **Custom** | LLM (any OpenAI-compatible API) | Requires Endpoint + Model Name |
| **Microsoft Translator** | Traditional | Azure-based |
| **DeepL** | Traditional | European languages focus |
| **Yandex** | Traditional | Russian language focus |

### LLM Options

| Option | Description |
|---|---|
| **Extra Context** | Free-text instructions sent to the LLM alongside each translation request (e.g., "This is a fantasy manga. Keep honorifics.") |
| **Image Input** | Send the comic page image to the LLM for visual context, helping it understand references that are visible but not in the text |
| **Context Limit** | Maximum token context window (relevant for Custom engines) |

### API Credentials

Each engine requires its own key. Enter keys under **Settings → Credentials**.

| Engine | Required Fields |
|---|---|
| OpenAI | API Key |
| Google Gemini | API Key |
| Anthropic Claude | API Key |
| Deepseek | API Key |
| Grok | API Key |
| Custom | API Key + Endpoint URL + Model Name |
| Microsoft Azure | API Key + Endpoint |
| DeepL | API Key |
| Yandex | API Key |

**Save API Keys** checkbox: when enabled, credentials are stored in the system keychain (Windows Credential Manager / macOS Keychain / Linux Secret Service).

---

## 7. OCR Settings

Open **Settings → OCR**.

### OCR Engine

| Engine | Best For |
|---|---|
| **Default** | Language-optimized: Manga-OCR (Japanese), Pororo (Korean), PPOCRv5 (all others) |
| **Microsoft OCR** | Cloud-based Azure Vision; handles printed and handwritten text |
| **Gemini 2.0 Flash** | Google vision model; good for complex layouts |
| **Custom** | Any OCR API via user-defined endpoint |

### Backend

| Backend | Notes |
|---|---|
| **ONNX** | Default. Lighter weight, no GPU driver required |
| **PyTorch** | Enables GPU acceleration when an NVIDIA GPU is present |

---

## 8. Text Detection Settings

Open **Settings → Detection**.

Only one detector is available:

| Detector | Description |
|---|---|
| **RT-DETR-v2** | Real-time detection model trained on 11 000+ comics (manga, webtoons, Western). Detects both speech bubbles and standalone text regions. |

---

## 9. Inpainting (Text Removal) Settings

Open **Settings → Inpainting**.

### Model

| Model | Best For |
|---|---|
| **LaMa** | Manga and anime; trained specifically on illustrated content (default) |
| **AOT-GAN** | General content; attention-based architecture |

### HD Strategy

Controls how large images are handled before inpainting.

| Strategy | Description | Parameter |
|---|---|---|
| **Resize** | Downscales the longer side before inpainting, then upscales result | **Resize Limit** (px, 1–3000, default 960) |
| **Crop** | Crops a region around each masked area and inpaints it at full resolution | **Crop Margin** (px) and **Crop Trigger Size** (px) |
| **Original** | Processes the full image without resizing — best quality, slowest | None |

### GPU Acceleration

A **Use GPU** checkbox appears automatically when an NVIDIA GPU is detected. Enabling it significantly speeds up inpainting and OCR.

---

## 10. Text Rendering & Fonts

Controls in the right-hand **Settings Panel** (visible while editing a page).

### Font

| Option | Description |
|---|---|
| **Font Family** | Select from system fonts |
| **Import Font** | Load a custom font file (TTF, TTC, OTF, WOFF, WOFF2) |
| **Min / Max Font Size** | Mukai-Translate auto-fits text; these clamp the range (9–100 pt) |
| **Uppercase** | Renders all translated text in uppercase |

### Style & Alignment

| Option | Values |
|---|---|
| **Alignment** | Left · Center · Right |
| **Bold** | On / Off |
| **Italic** | On / Off |
| **Underline** | On / Off |
| **Line Spacing** | Numeric multiplier |

### Color

| Option | Description |
|---|---|
| **Font Color** | Text fill color (default: black) |
| **Outline Color** | Stroke drawn around each character (default: white) |
| **Outline Width** | Thickness of the outline stroke |

All color/font changes show a **live preview** on the canvas.

---

## 11. Canvas Tools

### Navigation

| Action | How |
|---|---|
| Zoom in / out | Ctrl + Mouse Wheel |
| Pan | Click and drag on empty canvas area |
| Fit to view | Double-click empty canvas area |
| Previous / next page | Left / Right arrow keys |

### Text Block Tools

| Tool | Description |
|---|---|
| **Select** | Click a detected text box to select it; resize handles appear |
| **Move** | Drag a selected box to reposition it |
| **Resize** | Drag a corner/edge handle |
| **Rotate** | Drag the rotation handle above a selected box |
| **Delete block** | Select and press Delete, or use toolbar button |
| **Batch delete** | Shift/Ctrl-click multiple blocks, then delete |
| **Change all sizes** | +/- buttons in toolbar adjust font size on all blocks |
| **Restore blocks** | Reloads previously detected block data from project memory |

### Drawing Tools

| Tool | Description |
|---|---|
| **Brush** | Freehand paint strokes (variable size) — use to mark inpaint areas manually |
| **Eraser** | Erase brush strokes |
| **Brush/Eraser Size** | Slider in toolbar |
| **Clear Strokes** | Remove all brush strokes on the current page |
| **Segmentation Preview** | Overlay showing detected text areas before OCR |

---

## 12. Page / Image Management

The **Page List** sidebar on the left shows a thumbnail of every imported page.

| Action | How |
|---|---|
| Navigate to page | Click thumbnail |
| Reorder pages | Drag and drop thumbnail |
| Select multiple pages | Shift-click or Ctrl-click |
| **Translate selected** | Right-click selection → Translate Selected |
| **Skip / Un-skip** | Right-click → Toggle Skip (skipped pages are excluded from batch runs) |
| **Delete pages** | Select then press Delete or right-click → Delete |
| **Insert images** | Right-click in list → Insert Images |

### Skip Status

Skipped pages show a visual indicator on their thumbnail. After a batch run, the **Batch Report** lists all skipped pages along with the reason each was skipped (user-marked, OCR failure, translation error, etc.).

---

## 13. Search & Replace

Open with **Ctrl+H** or the menu.

### Search Options

| Option | Description |
|---|---|
| **Find field** | Text or regex pattern to search for |
| **Case Sensitive** | Toggle case matching |
| **Whole Word** | Match complete words only |
| **Regex** | Interpret the search pattern as a regular expression |

### Replace Options

| Option | Description |
|---|---|
| **Replace field** | Replacement text |
| **Replace** | Replace the current match |
| **Replace All** | Replace every match in the selected scope |

### Scope

| Scope | Description |
|---|---|
| **Current Image** | Search only the visible page |
| **All Images** | Search across every page in the project |
| **Source Text** | Search the OCR'd original text |
| **Translated Text** | Search the translation field |

The results tree shows page number and surrounding context. Click any result to jump to that page and select that block.

---

## 14. Webtoon Mode

Activate with the **Webtoon** toggle in the toolbar (also auto-enabled for vertical-format files).

| Feature | Description |
|---|---|
| **Vertical Scroll** | Pages are displayed as one continuous vertical strip |
| **Lazy Loading** | Pages load on demand, reducing memory usage for long series |
| **Continuous Scroll** | Smooth scrolling between pages without discrete page jumps |
| **Batch Processing** | Automatic mode processes all webtoon pages in order |

---

## 15. Project Management

Projects are saved as `.mtpr` files (legacy: `.ctpr`). A project file contains:

- All imported images
- Detected text block coordinates
- Original OCR'd text and translations
- Font/formatting settings per block
- Source and target language per page
- Skip status and undo/redo history
- Batch reports

| Action | Shortcut / Location |
|---|---|
| **Save** | Ctrl+S |
| **Save As** | Ctrl+Shift+S |
| **Open / Load** | Ctrl+O |
| **New Project** | File menu or Home screen |

---

## 16. Auto-Save

| Setting | Description |
|---|---|
| **Auto-Save toggle** | Enable/disable in the title bar |
| **Interval** | 1–120 minutes (default: 3 minutes); set in Settings → General |
| **Auto-Save folder** | Custom folder for auto-save snapshots (Settings → General) |
| **Crash recovery** | On next launch, if an unsaved project is detected, a recovery dialog prompts to restore it |

---

## 17. Account & Credits

Open **Settings → Account**.

| Element | Description |
|---|---|
| **Sign In** | Opens browser-based authentication |
| **Sign Out** | Logs out of the current account |
| **Email** | Displays the signed-in account email |
| **Subscription tier** | Shows current plan |
| **Credits balance** | Remaining credits for cloud API calls |
| **Buy Credits** | Link to the pricing/purchase page |

If credits run out mid-batch, a dialog appears with a **Buy Credits** button and the batch stops gracefully.

---

## 18. Application Settings

Open via the **Settings** gear icon or the menu.

### General

| Setting | Options |
|---|---|
| **Theme** | Dark · Light |
| **UI Language** | English, Korean, French, Simplified Chinese, Russian, Japanese, German, Spanish, Italian, and more. *Requires restart.* |
| **Auto-Save Interval** | 1–120 minutes |
| **Auto-Save Folder** | Custom directory path |

### Shortcuts

Displays every keyboard shortcut. Click any row to rebind the action to a new key combination. Changes are saved immediately.

---

## 19. Export

Open **Settings → Export** or use **File → Export**.

| Option | Description |
|---|---|
| **Export Raw Text** | Save OCR'd source text to `.txt` files, one per page |
| **Export Translated Text** | Save translated text to `.txt` files, one per page |
| **Export Inpainted Image** | Save cleaned (text-removed) images without rendered translations |
| **Export Translated Image** | Save the final image with translated text rendered in |

---

## 20. Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| **Left Arrow** | Previous page |
| **Right Arrow** | Next page |
| **Ctrl + Z** | Undo |
| **Ctrl + Y** | Redo |
| **Ctrl + S** | Save project |
| **Ctrl + Shift + S** | Save As |
| **Ctrl + O** | Open project |
| **Ctrl + H** | Open Search & Replace |
| **Ctrl + Mouse Wheel** | Zoom canvas |
| **Delete** | Delete selected block(s) |

All shortcuts can be customized in **Settings → Shortcuts**.

---

## 21. Workflows

### Automatic (Batch) Workflow

1. Import image files, PDFs, or archives.
2. Set **Source** and **Target** languages; click **Set All** if all pages are the same language pair.
3. Open **Settings** and configure the translator, OCR engine, and inpainting model.
4. Optionally mark pages to **skip** in the page list.
5. Click **Translate** in the toolbar.
6. Monitor the progress bar; click **Cancel** to stop at any time.
7. When complete, click **Batch Report** to review any skipped pages.
8. Switch to **Manual mode** to fix individual errors.
9. **Save** the project (Ctrl+S).

### Manual (MTPE) Workflow

1. Import files and navigate to the first page.
2. Click **Block Detect** to find text regions.
3. Adjust bounding boxes on canvas if needed (**Load Segmentation**).
4. Click **OCR** to extract text.
5. Click **Translate** to get the translation.
6. Click **Inpaint & Set** to remove the original text.
7. Edit the translation text in the sidebar if needed.
8. Click **Render** to place the translated text.
9. Adjust font, size, color, and alignment in the settings panel.
10. Use **Undo** (Ctrl+Z) to revert any step.
11. Advance to the next page with the Right Arrow key and repeat.
12. **Save** frequently (Ctrl+S or rely on Auto-Save).

---

## 22. Error Handling

| Message Type | Description |
|---|---|
| **Success** | Confirmation toast when translation or rendering completes |
| **Error dialog** | Detailed error text with a **Copy** button for reporting |
| **Content flagged** | The AI provider blocked the content; try a different translator or adjust the image |
| **Insufficient credits** | Account credits exhausted; a dialog offers a **Buy Credits** link |
| **Network error** | Connectivity issue with translation/OCR service; check internet connection |
| **Batch report** | After any batch run, lists every skipped image and the reason it was skipped |

---

*Mukai-Translate — powered by state-of-the-art LLMs for high-quality comic translation.*
