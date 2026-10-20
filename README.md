# Moiz Irshad — Mobile Engineering Lead

A responsive Flutter Web portfolio for a mobile engineering lead with 12+ years across native iOS, Android, Flutter and product delivery. Based in Dubai, UAE. The site includes all 15 LinkedIn projects, project filtering, individual case-study routes, a dark/light theme toggle, verified experience, an AI-driven development section, education and credential details, an architecture overview, skills, contact links and a CV download.

## Run locally

Install Flutter stable, then:

```sh
flutter pub get
flutter run -d chrome
```

## Verify and build

```sh
flutter analyze
flutter test
flutter build web --release --base-href /moizirshad/
```

The GitHub Actions workflow runs analysis, tests and the release build, then deploys `build/web` to GitHub Pages. The verified repository name is `moizirshad`, so the project-site base path is `/moizirshad/`. Enable Pages in repository settings with **GitHub Actions** as the build and deployment source. The workflow deploys on pushes to `main` and can be run manually.

Flutter Web uses client-side rendering. The site includes page metadata, Open Graph preview art, a favicon, robots.txt and a sitemap, but search engines may not index every dynamically rendered case study. Keep the home page descriptive and add pre-rendered HTML if search visibility for individual case studies becomes important. Routes use Flutter's default hash routing, which can be refreshed on static hosting.

For a custom domain, configure the domain in GitHub Pages, add its DNS records, and update the canonical URL, sitemap and Open Graph URL/image in `web/index.html` and `web/robots.txt`.

## Content and verified scope

Project content lives separately in `lib/data/projects.dart`; the experience and skills source is in `lib/main.dart`. The gallery contains all 15 entries in the LinkedIn Projects section. Supplied app artwork is bundled locally in `assets/projects/` and shown across project cards and case studies. The CV download is served as a static file from `web/cv/` so GitHub Pages publishes it at a stable URL. Add projects to the shared `Project` model and provide evidence, role, platforms, technologies, outcomes and links before including them. Case-study pages use the same fields and deliberately leave unknown details out.

Included case studies:

- **FITT Meals:** Flutter apps built from scratch; the customer and meal figures are business-scale data, not app-specific usage metrics.
- **DubiCars:** native iOS/Android and Flutter work; 40% cross-platform feature development time improvement and individual performance/release outcomes from the CV. Download, rating and crash-free figures are product-wide.
- **Bykea:** sole iOS engineering for mobility and payment features; 2M+ daily active users is a platform figure.
- **Danat FZ LLC:** company name updated per request; the experience timeline covers mobile leadership and client delivery.
- **LinkedIn project gallery:** FITT Meals, DubiCars, Bykea, Argaam, SRMG IR, Akhbaar24, Al-Aseel, Saudi Re, Advanced Petrochemical, Al Jouf Cement, Taiba for Investment, Tasnee, The Quotes, The Send App and ISWallet.

Project cards load available app imagery and fall back to a project-branded illustration if a remote image is unavailable. The portfolio links the LinkedIn profile at `https://www.linkedin.com/in/moizirshad/`. The portfolio focuses on verified work and skills; no backend ownership is claimed beyond evidenced mobile API integration and collaboration.

## Information to confirm or add

- A named React Native project, if one should be represented as production experience.
- What was built for FITT Meals' NutriBot and the exact DubiCars Flutter migration approach.
- Original screenshots or demos for projects without publicly accessible media.
- Confirmation of the Danat end month, DubiCars work mode and FITT employment type (the site currently uses CV dates and its overlap note).
- Optional FITT product metrics and a concrete AI-assisted engineering example.
- If you want an exact custom domain, set it in GitHub Pages and update the SEO URLs.

## Deployment status

The live portfolio is currently hosted at [moizirshad.github.io/moizirshad](https://moizirshad.github.io/moizirshad/). This source project is being kept in a separate private repository so the public GitHub profile README and public website can remain available. The repository workflow builds and deploys to GitHub Pages when that repository has Pages configured for GitHub Actions.
