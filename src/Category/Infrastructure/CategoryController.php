<?php

namespace App\Category\Infrastructure;

use App\Category\Application\CategoryService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Annotation\Route;

class CategoryController extends AbstractController
{
    private CategoryService $service;

    public function __construct(CategoryService $categoryService)
    {
        $this->service = $categoryService;
    }

    #[Route('/category/{categoryId}', name: 'app_single_category')]
    public function singleCategory(int $categoryId): Response
    {
        $session = new Session();
        $token = $session->get('token');

        $category = $this->service->getCategory($categoryId);
        $inputs = [];
        $attributes = $category->getAttributes()->toArray();
        foreach ($attributes as $attribute){
            $inputs[] = [
                'id' => $attribute->getId(),
                'name' => $attribute->getName(),
                'type' => $attribute->getInputType(),
                'priority' => $attribute->getOrderPriority(),
                'required' => $attribute->isRequired(),
                'options' => $attribute->getProcessedOptions($categoryId),
            ];
        }
        return $this->render('category/index.html.twig', [
            'category' => $category,
            'inputs' => $inputs,
            'token' => $token,
        ]);
    }

    #[Route('api/category-list', name: 'app_category_list')]
    public function categoryList(): Response
    {
        $data = $this->service->getCategoryList();
        return $this->json($data);
    }
}
