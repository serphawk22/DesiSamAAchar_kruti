<?php

namespace App\Services;

use OpenAI;

class AiSummaryService
{
    public function generate($text)
    {
        $client = OpenAI::client(config('services.openai.key'));

       $prompt = "
Return ONLY valid JSON.

Format:
{
  \"summary\": [],
  \"sector\": \"\",
  \"impact\": [],
  \"companies\": [],
  \"global_impact\": [],
  \"learning\": []
}

Rules:

IMPACT:
- Generate EXACTLY 3 to 5 impact points
- Each point must explain WHY market moved
- Cover different angles:
  1. Company impact
  2. Sector impact
  3. Investor sentiment
  4. Economic/global factor (if any)

SUMMARY:
- Generate 3 to 5 detailed bullet points
- Each point must explain the news clearly
- Include numbers, company actions, and outcomes 

COMPANIES:
- Extract ONLY listed/public companies
- Prefer Indian stocks (NSE/BSE)
- Max 5 companies

GLOBAL IMPACT:
- Include macro/global relationships
- Generate EXACTLY 2–3 points

LEARNING:
- Explain difficult financial terms in simple language
- Generate EXACTLY 2–3 points
- Beginner friendly

GENERAL:
- Avoid generic lines like 'market sentiment affected'
- Be specific and insightful

News Article:
$text
";

        $response = $client->chat()->create([
            'model' => 'gpt-4o-mini',
            'messages' => [
                [
                    'role' => 'user',
                    'content' => $prompt
                ]
            ],
            'temperature' => 0.2
        ]);

        $result = $response->choices[0]->message->content;

        // Extract JSON safely
        preg_match('/\{.*\}/s', $result, $matches);

        if(isset($matches[0])) {
            return json_decode($matches[0], true);
        }

        return null;
    }
}