<?php

namespace App\Attributes\Domain;

use App\Attributes\Domain\Repository\AttributeValueRepository;
use App\Category\Domain\Category;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AttributeValueRepository::class)]
class AttributeValue
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column(nullable: true)]
    private ?int $dependents_values = null;

    #[ORM\ManyToOne(inversedBy: 'attributeValues')]
    private ?Attributes $attribute_id = null;

    #[ORM\ManyToOne(inversedBy: 'attributeValues')]
    private ?Category $category = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getDependentsValues(): ?int
    {
        return $this->dependents_values;
    }

    public function setDependentsValues(int $dependents_values): self
    {
        $this->dependents_values = $dependents_values;

        return $this;
    }

    public function getAttributeId(): ?Attributes
    {
        return $this->attribute_id;
    }

    public function setAttributeId(?Attributes $attribute_id): self
    {
        $this->attribute_id = $attribute_id;

        return $this;
    }

    public function getCategory(): ?Category
    {
        return $this->category;
    }

    public function setCategory(?Category $category): self
    {
        $this->category = $category;

        return $this;
    }
}
