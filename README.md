# UX 플로우 생성기 (Figma/FigJam 플러그인)

기획 md랑 피그마 링크만 주면 UX 플로우를 피그잼에 대신 그려주는 로컬 플러그인입니다.
프로젝트 문서나 생성된 플로우 JSON은 여기 안 올라갑니다. 이 레포는 플러그인 코드만 관리해요.

## 쓰는 법

제일 간단한 방법은 플러그인 안에서 바로 생성하는 거예요.

1. 피그잼에서 플러그인 실행 → UX Flow 탭
2. md 링크(GitHub)랑 피그마 링크 붙여넣기
3. [⚡ 플로우 생성 → 그리기] 클릭

끝. 서버가 md를 읽고 Claude가 플로우를 만들어서 캔버스에 바로 그려줍니다.
GitHub 폴더(tree) 링크를 주면 안에 있는 md를 전부 읽어요. 프라이빗 레포도 gh 로그인만 돼 있으면 됩니다.

Claude Code에서 `uxflow-generator` 스킬로 만들어도 되고, 그 경우 플러그인 목록에 뜬 플로우를 클릭하면 그려집니다.

## 처음 세팅 (새 컴퓨터)

```bash
git clone https://github.com/hy0909/uxflow-figjam-plugin.git
git clone https://github.com/hy0909/skills.git && ln -sfn "$(pwd)/skills/uxflow-generator" ~/.claude/skills/uxflow-generator
cd uxflow-figjam-plugin && ./start-server.sh
```

그리고 Figma Desktop에서 Plugins > Development > Import plugin from manifest... 로 이 폴더의 `manifest.json`을 등록하면 끝.
필요한 것: Node.js, gh CLI 로그인, Claude Code 로그인.

## 그릴 때 지키는 규칙

어떤 md를 넣어도 같은 모양이 나오게 플러그인이 강제하는 것들:

- 범례 자동 표시 — 타원=시작·종료, 사각형=화면, 둥근사각형=액션, 마름모=분기, 평행사변형=API
- 색은 회색=정상, 빨강=에러, 주황=예외, 파랑=API
- 라벨의 `*`는 (필수항목) 빨간 글씨로, `(선택)`은 (선택항목)으로 바꿔서 표기
- 테두리 1px, 폰트 Inter
- 참고 링크는 우측 상단에 라벨만 (📄 md, 🔗 피그마)
- 선이 노드를 가리거나 관통하지 않게 커넥터는 맨 뒤 레이어 + 방향 기반 부착

화면 정의서, 예외 케이스, 컴포넌트 명세 생성 기능도 있는데 이건 `기능명세-생성-로직-법칙.md` 참고.
