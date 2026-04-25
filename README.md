# kinght-html-ppt-skill

面向正式汇报、技术分享和产品叙事的 HTML PPT Agent Skill。  
它基于 [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill) 的主题、模板、布局、动画和演讲者模式能力，进一步沉淀各种交付级场景的版式规范、数据动效、页面导览和交付检查流程，让 AI 生成的 HTML 演示稿更接近可直接投屏的正式成果。

![HTML PPT Studio preview](https://raw.githubusercontent.com/lewislulu/html-ppt-skill/main/docs/readme/hero.gif)


> 一款专业级的 AgentSkill，让 AI 做出真正能打的 HTML 演示文稿。
> **36 套主题**、**15 套完整 deck 模板**、**31 种页面布局**、**47 个动效**
> (27 个 CSS + 20 个 Canvas FX)，加上全新的 **演讲者模式** —— 像素级
> 完美预览 + 逐字稿提词器 + 计时器。纯静态 HTML/CSS/JS，无需构建。

## 产品定位

`kinght-html-ppt-skill` 是一个“HTML 演示稿生产基座”：

- 用静态 HTML/CSS/JS 交付，可直接在浏览器中打开和演示。
- 默认适配中文正式汇报，强调清晰、稳重、数据可信和页面不溢出。
- 保留模板化生产能力，适合由 AI 根据材料快速生成多页演示稿。
- 强化数字、条形图、SVG 流程图等数据可视化动效。
- 内置键盘、鼠标滚轮、演讲者备注、侧边导览和页面总览能力。

适用场景包括：产品分享、技术分享、项目复盘、培训课程、发布会材料、汇报、周/月总结和多页图文内容等。

## 继承的原始能力

上游 `html-ppt-skill` 已经提供了一套完整的 HTML PPT Studio 能力，本项目在此基础上做产品化增强。

| 能力 | 内容 |
| --- | --- |
| 主题系统 | 36 套 CSS Token 主题，可通过一个主题文件切换整体视觉 |
| 整套模板 | 15 套 full-deck templates，覆盖产品发布、技术分享、周报、课程等场景 |
| 单页布局 | 31 种页面布局，如封面、目录、KPI、表格、流程、时间线、图表等 |
| 动画体系 | 27 个 CSS 动画 + 20 个 Canvas FX 动效 |
| 演讲者模式 | 支持当前页、下一页、演讲稿和计时器的独立演示窗口 |
| 静态交付 | 纯 HTML/CSS/JS，无需构建步骤 |

| Presenter Mode | Themes |
| --- | --- |
| ![Presenter mode](https://raw.githubusercontent.com/lewislulu/html-ppt-skill/main/docs/readme/presenter-mode.png) | ![Themes](https://raw.githubusercontent.com/lewislulu/html-ppt-skill/main/docs/readme/themes.png) |

| Templates | Layouts & Animations |
| --- | --- |
| ![Templates](https://raw.githubusercontent.com/lewislulu/html-ppt-skill/main/docs/readme/templates.png) | ![Layouts](https://raw.githubusercontent.com/lewislulu/html-ppt-skill/main/docs/readme/layouts.png) |

![Animations](https://raw.githubusercontent.com/lewislulu/html-ppt-skill/main/docs/readme/animations.png)

## 增强能力

### 1. 正式默认规范

- 默认使用 16:10 演示比例，适合会议室大屏和常规投屏。
- 默认交付 HTML 演示稿，不强制转成 PPTX。
- 每页默认加入隐藏演讲备注，正常投屏不可见，只在备注或演讲者模式中查看。
- 页面可见内容禁止出现来源、制作过程、工具名、生成说明等与交付过程相关的描述。
- 正文、表格、脚注、图表标签、SVG 文字等最小字号统一不低于 14px。
- 页面主体在页眉和页脚之间尽量垂直居中，避免下方大面积空白。
- 汇报页脚、页码和进度反馈保持克制，不喧宾夺主。

### 2. 数据页动效

针对领导汇报中常见的数字、条形图和流程图，固化了更稳定的入场动效：

- 数字指标从 `0` 递增到目标值。
- 条形图、进度条、对比条从 `0` 宽度增长到目标长度。
- SVG 流程、数据流向、治理闭环使用路径描边、脉冲、扫描和流动效果。
- 动效在切回页面时重新播放，适合现场讲解和反复定位。
- 动画保持克制，服务于数据理解，不做炫技型大面积动效。

### 3. 页面导航体验

在原有键盘翻页基础上，增加了更适合现场演示的页面定位能力：

- 鼠标滚轮可切换页面，并缩短误触后的冷却时间，让翻页更跟手。
- `E` 键打开左侧页面导览栏，展示页面缩略图、页码和标题。
- 导览栏支持点击跳转、`Esc` 返回、再次按 `E` 返回。
- 点击暗淡失焦的背景可返回当前页面。
- 鼠标移到最左侧窄悬停区时，先出现细高亮发光条，再经过微小延迟打开导览栏。
- 通过鼠标悬停打开的导览栏，在鼠标移开后自动收起。
- 通过 `E` 键打开的导览栏不会因鼠标移开而自动关闭。
- 导览栏 UI 使用更窄的宽度、隐式滚动条、轻量玻璃背景和高亮分割线。

### 4. 全屏页面总览

- `O` 键进入页面总览。
- 总览视图使用真实页面缩略图铺满整个屏幕，而不是占位标题卡。
- 缩略图根据页面数量自动计算行列，适配 8 页、18 页、20 页或更多页面。
- 点击任意缩略图即可跳转到对应页面。
- `O` 总览和 `E` 侧边导览互斥，避免两个导航层叠加。

### 5. 最终版式和字体检查

交付前建议执行固定检查：

- 渲染每一页截图，确认比例为 16:10。
- 检查标题、正文、图表、页脚、页码没有溢出或重叠。
- 检查小字号是否低于 14px。
- 检查每页主体是否在页眉和页脚之间保持视觉居中。
- 检查可见文字中没有来源、制作、工具、生成过程等描述。
- 检查数字递增、条形增长、SVG 动画和页面切回重播是否正常。
- 检查键盘、滚轮、`E` 导览、`O` 总览、`S` 演讲者模式和隐藏备注。
- 使用浏览器自动化或 Playwright 做控制台、截图和布局校验。

## 快捷键

| 快捷键 | 功能 |
| --- | --- |
| `←` / `→` / `Space` / `PgUp` / `PgDn` | 页面切换 |
| 鼠标滚轮 | 上一页 / 下一页 |
| `F` | 全屏 |
| `S` | 演讲者模式 |
| `N` | 备注抽屉 |
| `O` | 全屏页面总览 |
| `E` | 左侧页面导览 |
| `T` | 切换主题 |
| `A` | 切换示例动画 |
| `Esc` | 关闭导览、总览或弹层 |

## 快速开始

安装到支持 Agent Skills 的环境：

```bash
npx skills add https://github.com/<your-github-name>/kinght-html-ppt-skill
```

从模板创建一份演示稿：

```bash
./scripts/new-deck.sh my-report
open examples/my-report/index.html
```

Windows PowerShell：

```powershell
.\scripts\new-deck.ps1 my-report
Start-Process .\examples\my-report\index.html
```

装好后，任何支持 AgentSkill 的 agent（Claude Code / Codex / Cursor / OpenClaw 等）
都能用这套能力做 PPT。对 agent 说：

> 基于这份材料生成一份 18 页正式汇报用 HTML PPT。
> 要求 16:10、每页有隐藏演讲备注、数据页有数字递增和条形增长动画、
> 页面可用滚轮切换，E 键打开页面导览，O 键打开页面总览。
> 不要在页面中出现来源、制作过程或工具相关描述。
> "做一个小红书图文，9 张，白底柔和风"
> "做一份带演讲者模式的产品分享，我想要有逐字稿"


## 目录结构

```
knight-html-ppt-skill/
├── SKILL.md                      agent 入口
├── README.md                     英文 README
├── README.zh-CN.md               本文件
├── references/                   详细文档
│   ├── themes.md                 36 主题 + 使用场景
│   ├── layouts.md                31 布局
│   ├── animations.md             27 CSS + 20 FX 目录
│   ├── full-decks.md             15 完整 deck 模板
│   ├── presenter-mode.md         🎤 演讲者模式 + 逐字稿指南
│   └── authoring-guide.md        完整工作流
├── assets/
│   ├── base.css                  共享 tokens + 基础组件
│   ├── fonts.css                 web 字体引入
│   ├── runtime.js                键盘导航 + 演讲者模式 + 总览
│   ├── themes/*.css              36 主题 token 文件
│   └── animations/
│       ├── animations.css        27 个命名 CSS 动画
│       ├── fx-runtime.js         进入 slide 自动初始化 [data-fx]
│       └── fx/*.js               20 个 Canvas FX 模块
├── templates/
│   ├── deck.html                 最小起步模板
│   ├── theme-showcase.html       iframe 隔离的主题 tour
│   ├── layout-showcase.html      全部 31 布局
│   ├── animation-showcase.html   47 动画 slide
│   ├── full-decks-index.html     15 deck gallery
│   ├── full-decks/<name>/        15 个 scoped 多页 deck 模板
│   └── single-page/*.html        31 个布局文件（带示例数据）
├── scripts/
│   ├── new-deck.sh               脚手架
│   ├── render.sh                 headless Chrome → PNG
│   └── verify-output/            56 张自测截图
└── examples/demo-deck/           完整可运行的示例 deck
```

## 设计原则/理念

- 把“能生成”升级为“能汇报”：默认关注投屏、可读性、字体大小、数据可信和交互稳定。
- 把“页面好看”升级为“现场好用”：支持快速定位页面、回到当前页、查看备注和总览缩略图。
- 把“动画装饰”升级为“数据表达”：数字、条形图和 SVG 动效优先解释信息关系。
- 把“交付 HTML”升级为“交付可验收成果”：每次交付前做截图、文字、字体和交互检查。
- **Token 驱动的设计系统。** 所有颜色、圆角、阴影、字体决策都在
  `assets/base.css` + 当前主题文件里。改一个变量，整份 deck 优雅地重排。
- **Iframe 隔离预览。** 主题 / 布局 / 完整 deck 的 showcase 都用 `<iframe>`，
  确保每个预览都是真实、独立的渲染结果。
- **零构建。** 纯静态 HTML/CSS/JS。只有 webfont / highlight.js / chart.js
  (可选) 走 CDN。
- **资深设计师的默认值。** 字号规律、间距节奏、渐变、卡片处理都有态度 ——

## Roadmap

- 增加场景汇报、数据型分析、项目复盘等专用 full-deck 模板。
- 增加更完整的自动质检脚本，输出页面溢出、小字号和禁用词报告。
- 增加 PDF / PPTX 导出辅助流程。
- 增加更丰富的中文图表组件和数据页模板。
- 为页面导览、总览和演讲者模式提供更多主题外观。

## 致谢与许可

本项目基于 [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill) 的 MIT 许可代码与设计体系进行扩展。README 中的部分预览图来自上游项目的 `docs/readme/` 目录，用于说明继承能力；后续可替换为本项目自己的截图。

请在发布仓库时保留原项目许可和致谢信息。本项目新增部分默认按 MIT License 发布，除非你在仓库中另行声明。
